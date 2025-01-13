import 'package:assist_health/src/presentation/screens/user_screens/excercise/excercise.dart';
import 'package:assist_health/src/presentation/screens/user_screens/excercise/excercise_bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;
  final List<Exercise> exercises;
  final int currentIndex;

  const ExerciseDetailScreen({
    super.key,
    required this.exercise,
    required this.exercises,
    required this.currentIndex,
  });

  @override
  _ExerciseDetailScreenState createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  late int remainingTime;
  late bool isResting;
  late bool isPaused;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.exercise.duration;
    isResting = false;
    isPaused = false;
    startTimer();
  }

  void startTimer() async {
    while (remainingTime > 0) {
      if (isPaused) return;
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        remainingTime--;
      });
    }

    saveExerciseData(widget.exercise, widget.exercise.duration);

    if (widget.currentIndex == widget.exercises.length - 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bạn đã hoàn thành tất cả bài tập!')),
      );
      Navigator.pop(context); // Quay lại danh sách bài tập
      return;
    }

    if (!isResting) {
      setState(() {
        isResting = true;
        remainingTime = 10;
      });
      startTimer();
    } else {
      goToNextExercise();
    }
  }

  void goToNextExercise() {
    if (widget.currentIndex < widget.exercises.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ExerciseDetailScreen(
            exercise: widget.exercises[widget.currentIndex + 1],
            exercises: widget.exercises,
            currentIndex: widget.currentIndex + 1,
          ),
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  void goToPreviousExercise() {
    if (widget.currentIndex > 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ExerciseDetailScreen(
            exercise: widget.exercises[widget.currentIndex - 1],
            exercises: widget.exercises,
            currentIndex: widget.currentIndex - 1,
          ),
        ),
      );
    }
  }

  double calculateCalories(
      int durationInSeconds, double metValue, double weightInKg) {
    return (metValue * 3.5 * weightInKg / 200) * (durationInSeconds / 60);
  }

  void saveExerciseData(Exercise exercise, int duration) async {
    final firestore = FirebaseFirestore.instance;
    final currentUser = FirebaseAuth.instance.currentUser;
    final userUid = currentUser!.uid;
    final String completedDate = DateFormat('dd/MM/yyyy')
        .format(DateTime.now()); // Ngày tháng hoàn thành

    await firestore.collection('completed_exercises').add({
      'user_uid': userUid,
      'name': exercise.name,
      'calo': exercise.calories * (exercise.duration - remainingTime),
      // calculateCalories(
      //   (widget.exercise.duration - remainingTime) * 60, // Chuyển sang giây
      //   8, // MET giả định
      //   70, // Cân nặng giả định
      //),
      'duration': exercise.duration - remainingTime, // Thời gian đã tập
      'completed_at': completedDate, // Thời gian hoàn thành
      'description': exercise.description,
      'types': exercise.types,
      'imageUrl': exercise.imageUrl,
    }).then((value) {
      print('Dữ liệu bài tập đã được lưu vào Firestore');
    }).catchError((error) {
      print('Lỗi khi lưu bài tập: $error');
    });
  }

  void completeExercise() {
    if (widget.currentIndex == widget.exercises.length - 1) {
      // Nếu là bài tập cuối cùng
      saveExerciseData(
          widget.exercise, widget.exercise.duration - remainingTime);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bạn đã hoàn thành tất cả bài tập!')),
      );
      Navigator.pop(context); // Quay về danh sách bài tập
    } else {
      // Nếu không phải bài tập cuối cùng
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hoàn thành bài tập'),
          content: const Text('Bạn có muốn tiếp tục bài tập tiếp theo không?'),
          actions: [
            TextButton(
              onPressed: () {
                saveExerciseData(widget.exercise,
                    widget.exercise.duration - remainingTime); // Lưu bài tập
                Navigator.pop(context);
                goToNextExercise();
              },
              child: const Text('Có'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context), // Đóng dialog, không lưu
              child: const Text('Không'),
            ),
          ],
        ),
      );
    }
  }

  void skipExercise() {
    if (isResting) {
      goToNextExercise(); // Chuyển sang bài tập tiếp theo nếu đang trong thời gian nghỉ
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Bỏ qua bài tập này?'),
          content: const Text('Bài tập này sẽ không được lưu nếu bạn bỏ qua.'),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context), // Đóng dialog, không làm gì
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                goToNextExercise(); // Bỏ qua bài tập hiện tại
              },
              child: const Text('Bỏ qua'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(widget.exercise.name),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              showExerciseDetailBottomSheet(
                context,
                widget.exercise,
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.exercise.imageUrl,
                  width: 400,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),
                Text(
                  isResting ? 'Thời gian nghỉ' : widget.exercise.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                        value: remainingTime / widget.exercise.duration,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isResting ? Colors.orange : Colors.blue,
                        ),
                        strokeWidth: 10,
                      ),
                    ),
                    Text(
                      '${remainingTime}s',
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (!isResting)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        isPaused = !isPaused;
                      });
                      if (!isPaused) {
                        startTimer();
                      }
                    },
                    child: Text(isPaused ? 'Tiếp tục' : 'Tạm dừng'),
                  ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      if (!isResting) ...[
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.blueAccent.withOpacity(0.5),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ).copyWith(
                              elevation: WidgetStateProperty.all(8),
                              backgroundColor: WidgetStateProperty.resolveWith(
                                (states) => states.contains(WidgetState.pressed)
                                    ? Colors.blue.shade700
                                    : Colors.blue,
                              ),
                            ),
                            onPressed: goToPreviousExercise,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_back_ios,
                                    color: Colors.white, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  'Trước đó',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.orangeAccent.withOpacity(0.5),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ).copyWith(
                            elevation: WidgetStateProperty.all(8),
                            backgroundColor: WidgetStateProperty.resolveWith(
                              (states) => states.contains(WidgetState.pressed)
                                  ? Colors.orange.shade700
                                  : Colors.orange,
                            ),
                          ),
                          onPressed: skipExercise,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.skip_next,
                                  color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text('Bỏ qua',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.greenAccent.withOpacity(0.5),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ).copyWith(
                            elevation: WidgetStateProperty.all(8),
                            backgroundColor: WidgetStateProperty.resolveWith(
                              (states) => states.contains(WidgetState.pressed)
                                  ? Colors.green.shade700
                                  : Colors.green,
                            ),
                          ),
                          onPressed: completeExercise,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle,
                                  color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text('Xong',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
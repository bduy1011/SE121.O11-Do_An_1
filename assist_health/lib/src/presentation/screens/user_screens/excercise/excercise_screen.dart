import 'package:assist_health/src/others/theme.dart';
import 'package:assist_health/src/presentation/screens/user_screens/excercise/excercise_list_screen.dart';
import 'package:assist_health/src/presentation/screens/user_screens/excercise/history_excercise.dart';
import 'package:flutter/material.dart';

class DailyWorkoutScreen extends StatefulWidget {
  @override
  State<DailyWorkoutScreen> createState() => _DailyWorkoutScreenState();
}

class _DailyWorkoutScreenState extends State<DailyWorkoutScreen> {
  final beginnerWorkouts = [
    {
      'title': 'Bung Người Bắt Đầu',
      'time': '4 phút',
      'exercises': '5 bài tập',
      'image': 'assets/abs1.jpg',
      'type': 'Abs1',
    },
    {
      'title': 'Ngực Người Bắt Đầu',
      'time': '2 phút',
      'exercises': '2 bài tập',
      'image': 'assets/chest1.jpg',
      'type': 'Chest1',
    },
    {
      'title': 'Cánh Tay Người Bắt Đầu',
      'time': '5 phút',
      'exercises': '5 bài tập',
      'image': 'assets/arm1.jpg',
      'type': 'Arm1',
    },
    {
      'title': 'Chân Người Bắt Đầu',
      'time': '3 phút',
      'exercises': '4 bài tập',
      'image': 'assets/leg1.jpg',
      'type': 'Leg1',
    },
  ];

  final intermediateWorkouts = [
    {
      'title': 'Bung Trung Bình',
      'time': '4 phút',
      'exercises': '5 bài tập',
      'image': 'assets/abs2.jpg',
      'type': 'Abs2',
    },
    {
      'title': 'Ngực Trung Bình',
      'time': '6 phút',
      'exercises': '7 bài tập',
      'image': 'assets/chest2.jpg',
      'type': 'Chest2',
    },
    {
      'title': 'Cánh Tay Trung Bình',
      'time': '12 phút',
      'exercises': '18 bài tập',
      'image': 'assets/arm2.jpg',
      'type': 'Arm2',
    },
    {
      'title': 'Chân Trung Bình',
      'time': '5 phút',
      'exercises': '6 bài tập',
      'image': 'assets/leg2.jpg',
      'type': 'Leg2',
    },
  ];

  final advancedWorkouts = [
    {
      'title': 'Bung Nâng Cao',
      'time': '5 phút',
      'exercises': '6 bài tập',
      'image': 'assets/abs3.jpg',
      'type': 'Abs3',
    },
    {
      'title': 'Ngực Nâng Cao',
      'time': '5 phút',
      'exercises': '5 bài tập',
      'image': 'assets/chest3.jpg',
      'type': 'Chest3',
    },
    {
      'title': 'Cánh Tay Nâng Cao',
      'time': '3 phút',
      'exercises': '4 bài tập',
      'image': 'assets/arm3.jpg',
      'type': 'Arm3',
    },
    {
      'title': 'Chân Nâng Cao',
      'time': '3 phút',
      'exercises': '4 bài tập',
      'image': 'assets/leg3.jpg',
      'type': 'Leg3',
    },
  ];

  final GlobalKey beginnerKey = GlobalKey();
  final GlobalKey intermediateKey = GlobalKey();
  final GlobalKey advancedKey = GlobalKey();

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToSection(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final offset =
            box.localToGlobal(Offset.zero).dy + _scrollController.offset;
        _scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 2),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Widget buildWorkoutSection(
      String header, List<Map<String, String>> workouts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            header,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            final workout = workouts[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ExerciseListScreen(filterType: workout['type']!),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(workout['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout['title']!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${workout['time']} • ${workout['exercises']}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Tập luyện tại nhà'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Themes.gradientDeepClr, Themes.gradientLightClr],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HistoryExercise()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mục tiêu hàng tuần',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(7, (index) {
                        int day = 22 + index;
                        return Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: day == 25 ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: Text(
                            '$day',
                            style: TextStyle(
                              color: day == 25 ? Colors.white : Colors.black,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'THỬ THÁCH 7x4',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TOÀN THÂN THỬ THÁCH 7x4',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Bắt đầu hành trình tạo dáng cơ thể để tập trung vào tất cả các nhóm cơ và xây dựng cơ thể mơ ước của bạn trong 4 tuần!',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: Text(
                            'KHỞI ĐẦU',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            // Beginner Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => scrollToSection(beginnerKey),
                        child: Expanded(
                          child: Text(
                            'Người bắt đầu',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => scrollToSection(intermediateKey),
                        child: Expanded(
                          child: Text(
                            'Trung bình',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => scrollToSection(advancedKey),
                        child: Expanded(
                          child: Text(
                            'Nâng cao',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    key: beginnerKey,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildWorkoutSection('Người Bắt Đầu', beginnerWorkouts),
                    ],
                  ),
                  // Intermediate Section
                  Column(
                    key: intermediateKey,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildWorkoutSection('Trung Bình', intermediateWorkouts),
                    ],
                  ),
                  // Advanced Section
                  Column(
                    key: advancedKey,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildWorkoutSection('Nâng Cao', advancedWorkouts),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
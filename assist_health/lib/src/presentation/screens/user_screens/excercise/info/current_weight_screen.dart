import 'package:assist_health/src/others/theme.dart';
import 'package:assist_health/src/presentation/screens/user_screens/excercise/info/goal_weight_screen.dart';
import 'package:flutter/material.dart';

class CurrentWeightScreen extends StatefulWidget {
  final String selectedGender;
  final int selectedAge;
  final int selectedHeight;
  final String selectedWeightChange;
  const CurrentWeightScreen({
    Key? key,
    required this.selectedGender,
    required this.selectedAge,
    required this.selectedHeight,
    required this.selectedWeightChange,
  }) : super(key: key);
  @override
  _CurrentWeightScreenState createState() => _CurrentWeightScreenState();
}

class _CurrentWeightScreenState extends State<CurrentWeightScreen> {
  int integerPart = 70;
  int decimalPart = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin sức khoẻ'),
        centerTitle: true,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Themes.gradientDeepClr, Themes.gradientLightClr],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Cân nặng hiện tại của bạn là bao nhiêu?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Ước tính bây giờ, có thể điều chỉnh sau.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bộ chọn phần nguyên
                Column(
                  children: [
                    Container(
                      height: 200,
                      width: 100,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 80,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            integerPart = 30 + index;
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            return Center(
                              child: Text(
                                '${30 + index}',
                                style: TextStyle(
                                    fontSize:
                                        index + 30 == integerPart ? 68 : 54,
                                    fontWeight: index + 30 == integerPart
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: index + 30 == integerPart
                                        ? Colors.black
                                        : Colors.grey),
                              ),
                            );
                          },
                          childCount: 71, // Giới hạn từ 30kg đến 100kg
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  ".",
                  style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                ),
                // Bộ chọn phần thập phân
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 60,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 80,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            decimalPart = index;
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            return Center(
                              child: Text(
                                '$index',
                                style: TextStyle(
                                    fontSize: index == decimalPart ? 68 : 54,
                                    fontWeight: index == decimalPart
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: index == decimalPart
                                        ? Colors.black
                                        : Colors.grey),
                              ),
                            );
                          },
                          childCount: 10, // Phần thập phân từ 0 đến 9
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  " kg",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  double weight = integerPart + (decimalPart / 10);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoalWeightScreen(
                        selectedGender: widget.selectedGender,
                        selectedAge: widget.selectedAge,
                        selectedHeight: widget.selectedHeight,
                        selectedWeightChange: widget.selectedWeightChange,
                        selectedCurrentWeight: weight,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Tiếp theo",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

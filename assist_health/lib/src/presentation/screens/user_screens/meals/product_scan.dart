import 'package:assist_health/src/others/theme.dart';
import 'package:assist_health/src/presentation/screens/user_screens/meals/product_screen.dart';
import 'package:assist_health/src/presentation/screens/user_screens/meals/favorite_meals.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductScanScreen extends StatefulWidget {
  const ProductScanScreen({super.key});

  @override
  _ProductScanScreenState createState() => _ProductScanScreenState();
}

class _ProductScanScreenState extends State<ProductScanScreen> {
  File? _image;

  Future<void> _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _navigateToProductScreen();
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _navigateToProductScreen();
    }
  }

  void _navigateToTextEntryScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TextEntryScreen(),
      ),
    );
  }

  void _navigateToProductScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductScreen(image: _image!),
      ),
    );
  }

  void _navigateToFavoriteMealsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteMealsScreen(),
      ),
    );
  }

  int _selectedIndex = 1;

  void _onBottomNavigationBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      _pickImageFromGallery();
    } else if (index == 1) {
      _pickImageFromCamera();
    } 
    // else if (index == 2) {
    //   _navigateToTextEntryScreen();
    // } 
    else if (index == 2) {
      _navigateToFavoriteMealsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Chọn cách bắt đầu phân tích'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Chọn một cách để bắt đầu",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            IconButton(
              iconSize: 80,
              icon: const Icon(Icons.camera_alt, color: Themes.gradientDeepClr),
              onPressed: _pickImageFromCamera,
            ),
            const Text(
              "Chụp ảnh",
              style: TextStyle(fontSize: 16, color: Themes.gradientLightClr),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavigationBarTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            label: "Chọn từ album",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: "Chụp ảnh",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.text_fields),
          //   label: "Nhập mô tả",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Yêu thích",
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}

class TextEntryScreen extends StatelessWidget {
  const TextEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Nhập mô tả'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/describe_food.jpg'),
            const SizedBox(height: 40),
            TextField(
              // controller: ,
              style: TextStyle(color: Colors.grey[600]),
              decoration: InputDecoration(
                labelText: "Nhập mô tả món ăn",
                labelStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey[400]!,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey[400]!,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey[500]!,
                    width: 2.0,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send, color: Colors.grey[600]),
                  onPressed: () {},
                  tooltip: "Gửi",
                ),
              ),
              maxLines: 5,
              minLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

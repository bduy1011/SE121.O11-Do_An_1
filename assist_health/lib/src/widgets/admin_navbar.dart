import 'package:assist_health/src/others/theme.dart';
import 'package:assist_health/src/presentation/screens/admin_screens/admin_account.dart';
import 'package:assist_health/src/presentation/screens/admin_screens/admin_blog_list.dart';
import 'package:assist_health/src/presentation/screens/admin_screens/admin_payment_management_screen.dart';
import 'package:assist_health/src/presentation/screens/admin_screens/content_topbar.dart';
import 'package:assist_health/src/presentation/screens/admin_screens/message_admin.dart';
import 'package:assist_health/src/presentation/screens/admin_screens/shop_chart.dart';
import 'package:assist_health/src/presentation/screens/admin_screens/store/voucher/add_voucher_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminNavBar extends StatefulWidget {
  const AdminNavBar({super.key});

  @override
  State<AdminNavBar> createState() => _AdminNavBarState();
}

class _AdminNavBarState extends State<AdminNavBar> {
  int _selectedIndex = 0;
  final _screens = [
    // Screen 1
    const AdminPaymentManagementScreen(),
    // const RevenueChartScreen(),
    // ReviewManagementPage(),
    const ShopChart(),
    const AdminBlog(),
    // const AddVoucherScreen(),
    // Screen 2
    const ContentTopBar(),
    // Screen 3
    const MessageAdminScreen(),
    // Screen 4
    // const DoctorProfileList(),
    // Screen 5
    const AdminAccountScreen(),
    //Screen 6
    // const ProductListScreen(),
    //Screen 7
    // const AdminOrderManagementScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Themes.selectedClr,
          unselectedItemColor: Colors.black26,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.payment_rounded),
              label: "Thanh toán",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_rounded),
              label: "Doanh thu",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined),
              label: "Bài viết",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books_rounded),
              label: "Nội dung",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_text_fill),
              label: "Tin nhắn",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(FontAwesomeIcons.userDoctor),
            //   label: "Bác sĩ",
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Tài khoản",
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/screens/cart_screen/cart_screen.dart';
import 'package:ecommerce_app/screens/home_screen/home_screen.dart';
import 'package:ecommerce_app/screens/main_screen/widgets/nav_bar.dart';
import 'package:ecommerce_app/screens/main_screen/widgets/nav_bar_item.dart';
import 'package:ecommerce_app/screens/notification_screen/notification_screen.dart';
import 'package:ecommerce_app/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    const CartScreen(),
    const NotificationScreen(),
    const ProfileScreen()
  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: screens[currentIndex],
      bottomNavigationBar: NavBar(
        onTap: onTap,
        currentIndex: currentIndex,
      ),
    );
  }
}

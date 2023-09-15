import 'package:ecommerce_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/screens/cart_screen/cart_screen.dart';
import 'package:ecommerce_app/screens/home_screen/home_screen.dart';
import 'package:ecommerce_app/screens/main_screen/widgets/nav_bar.dart';
import 'package:ecommerce_app/screens/notification_screen/notification_screen.dart';
import 'package:ecommerce_app/screens/profile_screen/profile_screen.dart';
import 'package:ecommerce_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const String routeName = '/main-screen';
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
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        currentIndex = 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, SignInScreen.routeName, (route) => route.isFirst);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: screens[currentIndex],
        bottomNavigationBar: NavBar(
          onTap: onTap,
          currentIndex: currentIndex,
        ),
      ),
    );
  }
}

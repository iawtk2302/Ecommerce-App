import 'package:ecommerce_app/screens/category_product_screen/category_product_screen.dart';
import 'package:ecommerce_app/screens/category_screen/category_screen.dart';
import 'package:ecommerce_app/screens/detail_product_screen/detail_product_screen.dart';
import 'package:ecommerce_app/screens/main_screen/main_screen.dart';
import 'package:ecommerce_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:ecommerce_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:ecommerce_app/screens/sign_up_screen/sign_up_screen.dart';
import 'package:ecommerce_app/screens/sign_up_screen/sign_up_success_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnboardingScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case SignInScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        );
      case SignUpScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      case SignUpSuccessScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SignUpSuccessScreen(),
        );
      case MainScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const MainScreen(),
        );
      case CategoryScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const CategoryScreen(),
        );
      case CategoryProductScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const CategoryProductScreen(),
        );
      case DetailProductScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const DetailProductScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("No route"),
            ),
          ),
        );
    }
  }
}

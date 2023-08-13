import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/category_product_screen/category_product_screen.dart';
import 'package:ecommerce_app/screens/category_screen/category_screen.dart';
import 'package:ecommerce_app/screens/detail_product_screen/detail_product_screen.dart';
import 'package:ecommerce_app/screens/filter_screen/filter_screen.dart';
import 'package:ecommerce_app/screens/main_screen/main_screen.dart';
import 'package:ecommerce_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:ecommerce_app/screens/product_screen/product_screen.dart';
import 'package:ecommerce_app/screens/search_screen/search_screen.dart';
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
        {
          try {
            final Category category = settings.arguments as Category;
            return MaterialPageRoute(
              builder: (context) => CategoryProductScreen(
                category: category,
              ),
            );
          } catch (e) {
            print(e.toString());
          }
        }
      case DetailProductScreen.routeName:
        {
          try {
            final Product product = settings.arguments as Product;
            return MaterialPageRoute(
              builder: (context) => DetailProductScreen(
                product: product,
              ),
            );
          } catch (e) {
            print(e.toString());
          }
        }
      case FilterScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const FilterScreen(),
        );
      case SearchScreen.routeName:
        {
          try {
            final String query = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => SearchScreen(
                query: query,
              ),
            );
          } catch (e) {
            print(e.toString());
          }
        }
      case ProductScreen.routeName:
        {
          try {
            final Map<String, dynamic> arg =
                settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => ProductScreen(
                sectionName: arg['sectionName'],
                products: arg['products'],
              ),
            );
          } catch (e) {
            print(e.toString());
          }
        }

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

import 'package:ecommerce_app/screens/add_address_screen/add_address_screen.dart';
import 'package:ecommerce_app/screens/add_payment_card_screen/add_payment_card_screen.dart';
import 'package:ecommerce_app/screens/choose_address_screen/choose_address_screen.dart';
import 'package:ecommerce_app/screens/choose_promotion_screen/choose_promotion_screen.dart';
import 'package:ecommerce_app/screens/main_screen/main_screen.dart';
import 'package:ecommerce_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:ecommerce_app/screens/payment_screen/payment_screen.dart';
import 'package:ecommerce_app/screens/place_order_screen/place_order_screen.dart';
import 'package:ecommerce_app/screens/set_passcode_screen/set_passcode_screen.dart';
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
      case PlaceOrderScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const PlaceOrderScreen(),
        );
      case PaymentScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const PaymentScreen(),
        );
      case AddAddressScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const AddAddressScreen(),
        );
      case ChooseAddressScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ChooseAddressScreen(),
        );
      case ChoosePromotionScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ChoosePromotionScreen(),
        );
      case AddPaymentCardScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const AddPaymentCardScreen(),
        );
      case SetPasscodeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SetPasscodeScreen(),
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

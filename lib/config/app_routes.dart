import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/order_product_detail.dart';
import 'package:ecommerce_app/screens/add_address_screen/add_address_screen.dart';
import 'package:ecommerce_app/screens/add_payment_card_screen/add_payment_card_screen.dart';
import 'package:ecommerce_app/screens/choose_address_screen/choose_address_screen.dart';
import 'package:ecommerce_app/screens/choose_promotion_screen/choose_promotion_screen.dart';
import 'package:ecommerce_app/screens/main_screen/main_screen.dart';
import 'package:ecommerce_app/screens/my_order_screen/my_order_screen.dart';
import 'package:ecommerce_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:ecommerce_app/screens/order_tracking_screen/order_tracking_screen.dart';
import 'package:ecommerce_app/screens/payment_screen/payment_screen.dart';
import 'package:ecommerce_app/screens/order_processing_screen/order_processing_screen.dart';
import 'package:ecommerce_app/screens/place_order_screen/place_order_screen.dart';
import 'package:ecommerce_app/screens/review_screen/review_screen.dart';
import 'package:ecommerce_app/screens/set_passcode_screen/set_passcode_screen.dart';
import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/category_product_screen/category_product_screen.dart';
import 'package:ecommerce_app/screens/category_screen/category_screen.dart';
import 'package:ecommerce_app/screens/detail_product_screen/detail_product_screen.dart';
import 'package:ecommerce_app/screens/filter_screen/filter_screen.dart';
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
      case OrderProcessingScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const OrderProcessingScreen(),
        );
      case OrderTrackingScreen.routeName:
        final args = settings.arguments as OrderTrackingArguments;
        return MaterialPageRoute(
          builder: (context) => OrderTrackingScreen(
            order: args.order,
            orderItem: args.orderItem,
          ),
        );
      case MyOrderScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const MyOrderScreen(),
        );
      case ReviewScreen.routeName:
        try {
          final String productId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => ReviewScreen(
              productId: productId,
            ),
          );
        } catch (e) {
          print(e.toString());
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

class OrderTrackingArguments {
  final OrderModel order;
  final OrderProductDetail? orderItem;

  const OrderTrackingArguments({required this.order, this.orderItem});
}

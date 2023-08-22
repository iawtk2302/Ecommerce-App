import 'package:ecommerce_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_app/blocs/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/screens/main_screen/main_screen.dart';
import 'package:ecommerce_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:ecommerce_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool firstTime =
      true; // It is used for marking this is the first time load user for whole app.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Utils().isAlreadyUsedOnboarding().then((value) {
            if (value) {
              Navigator.pushNamedAndRemoveUntil(
                  context, SignInScreen.routeName, (route) => false);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, OnboardingScreen.routeName, (route) => false);
            }
          });
        } else if (state is Authenticated) {
          context.read<UserBloc>().add(LoadUser());
        } else if (state is AuthenticationFailure) {
          Utils.showSnackBar(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        return BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoaded && firstTime) {
              firstTime = false;
              context.read<HomeBloc>().add(const LoadHome());
              context
                  .read<PlaceOrderBloc>()
                  .add(UpdateAddress(state.user.defaultShippingAddress));

              // Only the first time load user, we need to navigate to MainScreen
              Navigator.pushNamedAndRemoveUntil(
                  context, MainScreen.routeName, (route) => false);
            } else if (state is UserError) {
              Utils.showSnackBar(
                  context: context,
                  message: "Some error occurred. Please sign in again!");
              Navigator.pushNamedAndRemoveUntil(
                  context, SignInScreen.routeName, (route) => false);
            }
          },
          builder: (context, state) {
            return Image.asset(
              AppAssets.imgSplashBackground,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            );
          },
        );
      },
    ));
  }
}

import 'package:ecommerce_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:ecommerce_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:ecommerce_app/screens/test_screen.dart';
import 'package:ecommerce_app/ultils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 3), () {
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, OnboardingScreen.routeName, (route) => false);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Utils().isAlreadyUsedOnboarding().then((value) {
            if (value) {
              Navigator.pushNamed(context, SignInScreen.routeName);
            } else {
              Navigator.pushNamed(context, OnboardingScreen.routeName);
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
            if (state is UserLoaded) {
              Navigator.pushNamed(context, TestScreen.routeName);
            } else if (state is UserError) {
              Utils.showSnackBar(
                  context: context,
                  message: "Some error occurred. Please sign in again!");
              Navigator.pushNamed(context, SignInScreen.routeName);
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

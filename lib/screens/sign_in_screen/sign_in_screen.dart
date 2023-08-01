import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static const routeName = "/sign-in-screen";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text("Sign in screen"),
    ));
  }
}

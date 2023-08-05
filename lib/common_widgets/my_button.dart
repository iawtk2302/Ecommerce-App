import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? margin;
  final EdgeInsets padding;

  const MyButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.margin,
    this.backgroundColor = AppColors.primaryColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: padding,
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

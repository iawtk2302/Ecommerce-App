import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color backgroundColor;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? margin;
  final EdgeInsets padding;
  final double borderRadius;
  final bool isEnable;
  final BorderSide borderSide;
  final Widget child;

  const MyButton({
    super.key,
    required this.onPressed,
    this.margin,
    this.backgroundColor = AppColors.primaryColor,
    this.borderRadius = 50,
    this.padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
    this.isEnable = true,
    this.borderSide = BorderSide.none,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: padding,
          minimumSize: Size(0, 0),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            side: borderSide,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: isEnable ? onPressed : null,
        child: child,
      ),
    );
  }
}

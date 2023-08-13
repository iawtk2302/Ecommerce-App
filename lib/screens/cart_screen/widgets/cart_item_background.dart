import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CartItemBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double borderRadius;
  final Color backgroundColor;
  const CartItemBackground({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.only(bottom: 15),
    this.padding = const EdgeInsets.fromLTRB(8, 8, 15, 8),
    this.borderRadius = 12,
    this.backgroundColor = AppColors.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 24,
              offset: const Offset(0, 11),
            )
          ]),
      child: child,
    );
  }
}

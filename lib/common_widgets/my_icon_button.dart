import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final Function onPressed;
  final Widget icon;
  final double size;
  const MyIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: size / 2,
        backgroundColor: AppColors.primaryColor,
        child: IconButton(onPressed: () => onPressed(), icon: icon));
  }
}

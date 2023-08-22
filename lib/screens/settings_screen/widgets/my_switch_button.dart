import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MySwitchButton extends StatelessWidget {
  const MySwitchButton({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
          value: value,
          activeColor: AppColors.whiteColor,
          activeTrackColor: AppColors.primaryColor,
          onChanged: onChanged),
    );
  }
}

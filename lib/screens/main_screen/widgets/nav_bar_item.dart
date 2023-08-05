import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem(
      {super.key,
      required this.iconName,
      required this.label,
      required this.isSelected,
      required this.onTap});
  final String iconName;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: isSelected
            ? IconWithText(
                iconName: iconName,
                label: label,
              )
            : MyIcon(icon: "${AppAssets.iconPath}/ic_${iconName}_black.svg"));
  }
}

class IconWithText extends StatelessWidget {
  final String iconName;
  final String label;

  const IconWithText({
    super.key,
    required this.iconName,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: AppColors.greyColor),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primaryColor),
              child: Center(
                  child: MyIcon(
                      icon: "${AppAssets.iconPath}/ic_${iconName}_white.svg"))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              label,
              style: AppStyles.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
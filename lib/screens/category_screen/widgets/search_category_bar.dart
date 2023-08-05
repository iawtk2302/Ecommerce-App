import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class SearchCategoryBar extends StatelessWidget {
  const SearchCategoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: AppColors.greyColor),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: MyIcon(icon: AppAssets.icSearch),
          ),
          Expanded(
              child: TextField(
            decoration: InputDecoration(
                hintStyle: AppStyles.bodyLarge,
                border: InputBorder.none,
                hintText: "Search Categories"),
          ))
        ],
      ),
    );
  }
}

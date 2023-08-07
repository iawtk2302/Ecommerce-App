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
      margin: const EdgeInsets.only(
          left: AppDimensions.defaultPadding,
          right: AppDimensions.defaultPadding,
          top: AppDimensions.defaultPadding,
          bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: AppColors.greyColor),
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
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

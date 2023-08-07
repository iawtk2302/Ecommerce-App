import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.defaultPadding, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome",
            style: AppStyles.displayLarge,
          ),
          const Text(
            "Our Fashion App",
            style: AppStyles.displayMedium,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.7,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppColors.greyColor,
                      borderRadius: BorderRadius.circular(40)),
                  child: const TextField(
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: MyIcon(
                              icon: AppAssets.icSearch,
                            )),
                        hintStyle: TextStyle(color: AppColors.primaryHintColor),
                        hintText: "Search...",
                        border: InputBorder.none),
                  ),
                ),
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.primaryColor,
                  child: MyIcon(
                    icon: AppAssets.icFilter,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

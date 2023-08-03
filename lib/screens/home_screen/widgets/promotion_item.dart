import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class PromotionItem extends StatelessWidget {
  const PromotionItem({super.key, required this.height, required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: const DecorationImage(
              image: NetworkImage(
                  "https://st3.depositphotos.com/7247698/18888/i/450/depositphotos_188885346-stock-photo-sport-shoes-art-design-banner.jpg"),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "50% Off",
            style: AppStyles.displayLarge,
          ),
          Text(
            "On everything today",
            style:
                AppStyles.headlineLarge.copyWith(fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "With code: ABCZYX",
              style: AppStyles.displayMedium.copyWith(fontSize: 12),
            ),
          ),
          const MyButton(
            width: 100,
            height: 35,
            child: Text(
              "Get now",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

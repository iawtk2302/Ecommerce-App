import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/models/promotion.dart';
import 'package:flutter/material.dart';

class PromotionItem extends StatelessWidget {
  const PromotionItem({
    super.key,
    required this.promotion,
    required this.height,
    required this.width,
    required this.onGetPromotion,
  });
  final Promotion promotion;
  final double height;
  final double width;
  final VoidCallback onGetPromotion;

  @override
  Widget build(BuildContext context) {
    final String name = switch (promotion.type) {
      PromotionType.freeShipping => "Free Shipping",
      PromotionType.percentage =>
        "${(promotion as PercentagePromotion).percentage}% Off",
      PromotionType.fixedAmount =>
        "${(promotion as FixedAmountPromotion).amount}\$ Off",
    };

    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(promotion.imgUrl), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
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
              "With code: ${promotion.code}",
              style: AppStyles.displayMedium.copyWith(fontSize: 12),
            ),
          ),
          MyButton(
            // width: 100,
            // height: 35,
            onPressed: onGetPromotion,
            child: const Text(
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

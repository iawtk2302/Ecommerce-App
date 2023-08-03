import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/promotion_item.dart';
import 'package:flutter/material.dart';

class ListPromotion extends StatelessWidget {
  const ListPromotion({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
          left: AppDimensions.defaultPadding, top: 8, bottom: 8),
      height: size.height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return PromotionItem(
              height: size.height * 0.25, width: size.width * 0.7);
        },
      ),
    );
  }
}

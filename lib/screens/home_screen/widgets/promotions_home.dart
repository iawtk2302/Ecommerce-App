import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/promotion_item.dart';
import 'package:flutter/material.dart';

class PromotionsHome extends StatelessWidget {
  const PromotionsHome({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return Container(
    //   margin: const EdgeInsets.only(
    //       left: AppDimensions.defaultPadding, top: 8, bottom: 8),
    //   height: size.height * 0.25,
    //   child: ListView.builder(
    //     scrollDirection: Axis.horizontal,
    //     itemCount: 5,
    //     itemBuilder: (context, index) {
    //       return PromotionItem(
    //         height: size.height * 0.25,
    //         width: size.width * 0.7,
    //       );
    //     },
    //   ),
    // );
    return Padding(
      padding: const EdgeInsets.only(left: AppDimensions.defaultPadding),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: List.generate(
                  5,
                  (index) => PromotionItem(
                        height: size.height * 0.2,
                        width: size.width * 0.7,
                      )))),
    );
  }
}

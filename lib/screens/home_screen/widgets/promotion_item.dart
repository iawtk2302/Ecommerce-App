import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/common_widgets/my_ink_well.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/models/promotion.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PromotionItem extends StatelessWidget {
  const PromotionItem(
      {super.key,
      required this.height,
      required this.width,
      required this.promotion});
  final double height;
  final double width;
  final Promotion promotion;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        CachedNetworkImage(
          imageUrl: promotion.imgUrl,
          imageBuilder: (context, imageProvider) => Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(12),
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: const Color(0xFFE0E0E0),
            highlightColor: const Color(0xFFF5F5F5),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(12),
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
            ),
          ), // Shimmer loading placeholder
          errorWidget: (context, url, error) =>
              const Icon(Icons.error), // Error widget
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "50% Off",
                style: AppStyles.displayLarge,
              ),
              Text(
                promotion.content,
                style: AppStyles.headlineLarge
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "With code: ${promotion.code}",
                  style: AppStyles.displayMedium.copyWith(fontSize: 12),
                ),
              ),
              MyInkWell(
                onTap: () {},
                width: size.width * 0.25,
                height: size.height * 0.04,
                child: const Text(
                  "Get now",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/cart_item_background.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final double? imageHeight;
  final double? imageWidth;
  final bool isAdjustable;

  const CartItemWidget({
    super.key,
    this.imageHeight,
    this.imageWidth,
    this.isAdjustable = true,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return CartItemBackground(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://neoshop.vn/wp-content/uploads/2023/02/t1-1-1.jpg",
              height: imageHeight ?? size.width * 0.21,
              width: imageWidth ?? size.width * 0.21,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "Roller Rabbit",
                  style: AppStyles.labelLarge,
                ),
                const Text(
                  "Vado Odelle Dress",
                  style: AppStyles.bodyLarge,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "\$40.00",
                      style: AppStyles.headlineLarge,
                    ),
                    if (isAdjustable)
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: AppDimensions.circleCorners,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: IconButton(
                                iconSize: 15,
                                splashRadius: 5,
                                onPressed: () {},
                                icon: const Icon(Icons.remove),
                              ),
                            ),
                            Text(
                              "1",
                              style: AppStyles.bodyLarge.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor),
                            ),
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: IconButton(
                                padding: const EdgeInsets.all(0),
                                iconSize: 15,
                                splashRadius: 5,
                                onPressed: () {},
                                icon: const Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
          // const Spacer(),
        ],
      ),
    );
  }
}

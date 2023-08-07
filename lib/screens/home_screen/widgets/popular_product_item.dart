import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class PopularProductItem extends StatelessWidget {
  const PopularProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        height: size.height * 0.13,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  offset: const Offset(0, 6),
                  spreadRadius: 1,
                  blurRadius: 5)
            ]),
        child: Row(
          children: [
            Container(
              height: size.height * 0.13,
              width: size.height * 0.13,
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/5b0981ff-45f8-40c3-9372-32430a62aaea/dunk-high-womens-shoes-PXHcGT.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gia Borgini",
                      style: AppStyles.labelLarge,
                    ),
                    Text(
                      "RHW Roise 1 Sandals",
                      style: AppStyles.bodyMedium,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          "(4.5)",
                          style: AppStyles.labelMedium,
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  "\$740.00",
                  style: AppStyles.labelLarge,
                )
              ],
            )),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}

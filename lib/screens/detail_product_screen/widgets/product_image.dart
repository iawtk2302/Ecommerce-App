import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/product_clipper.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipPath(
          clipper: ProductClipper(),
          child: Container(
            height: size.height * 0.45,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/5b0981ff-45f8-40c3-9372-32430a62aaea/dunk-high-womens-shoes-PXHcGT.png"),
                    fit: BoxFit.cover)),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: size.height * 0.45 * 1 / 5 * 3 / 2 * 0.9,
            height: size.height * 0.45 * 1 / 5 * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.black),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text(
                      "4.9",
                      style: AppStyles.bodyLarge.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Text("100 Reviews",
                    style: AppStyles.bodyMedium.copyWith(color: Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

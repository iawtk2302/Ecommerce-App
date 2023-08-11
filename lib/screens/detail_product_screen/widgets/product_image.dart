import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/product_clipper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Stack(
        children: [
          ClipPath(
              clipper: ProductClipper(),
              child: Container(
                height: size.height * 0.45,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(product.imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.imgUrl,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: const Color(0xFFE0E0E0),
                    highlightColor: const Color(0xFFF5F5F5),
                    child: Container(
                      color: Colors.white,
                    ),
                  ), // Shimmer loading placeholder
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error), // Error widget
                  fit: BoxFit.cover,
                ),
              )),
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
                        product.averageRating.toStringAsFixed(1),
                        style: AppStyles.bodyLarge.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Text("${product.reviewCount.toStringAsFixed(0)} Reviews",
                      style:
                          AppStyles.bodyMedium.copyWith(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

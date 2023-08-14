import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/cart_item_background.dart';
import 'package:flutter/material.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return CartItemBackground(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://product.hstatic.net/200000041086/product/bsic1_64d5323e287447e69d092dcc89970df4_master.jpg",
              height: size.width * 0.21,
              width: size.width * 0.21,
              fit: BoxFit.cover,
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Roller Rabbit",
                style: AppStyles.labelLarge,
              ),
              Text(
                "Vado Odelle Dress",
                style: AppStyles.bodyLarge,
              ),
              Text(
                "Quantity: 1",
                style: AppStyles.bodyMedium,
              ),
              Text(
                "Size: 1",
                style: AppStyles.bodyMedium,
              ),
              Text(
                "Color: 1",
                style: AppStyles.bodyMedium,
              ),
            ],
          ),
          // const Spacer(),
          const Text(
            "\$40.00",
            style: AppStyles.headlineLarge,
          )
        ],
      ),
    );
  }
}

import 'package:ecommerce_app/common_widgets/color_dot_widget.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/order_product_detail.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/cart_item_background.dart';
import 'package:flutter/material.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel order;
  final OrderProductDetail orderItem;
  final EdgeInsets margin;
  final VoidCallback? onTap;

  const OrderItemWidget({
    super.key,
    required this.order,
    required this.orderItem,
    this.margin = const EdgeInsets.symmetric(
        horizontal: AppDimensions.defaultPadding, vertical: 10),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: CartItemBackground(
        margin: margin,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                orderItem.productImgUrl,
                height: size.width * 0.21,
                width: size.width * 0.21,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderItem.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.labelLarge,
                  ),
                  if (orderItem.productBrand.isNotEmpty)
                    Text(
                      orderItem.productBrand,
                      style: AppStyles.bodyLarge,
                    ),
                  Text(
                    "Quantity: ${orderItem.quantity}",
                    style: AppStyles.bodyMedium,
                  ),
                  Text(
                    "Size: ${orderItem.size}",
                    style: AppStyles.bodyMedium,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Color: ",
                        style: AppStyles.bodyMedium,
                      ),
                      ColorDotWidget(color: orderItem.color.toColor())
                    ],
                  ),
                ],
              ),
            ),
            // const Spacer(),
            Text(
              orderItem.productPrice.toPriceString(),
              style: AppStyles.headlineLarge,
            )
          ],
        ),
      ),
    );
  }
}

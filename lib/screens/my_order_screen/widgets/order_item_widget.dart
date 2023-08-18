import 'package:ecommerce_app/config/app_routes.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/order_product_detail.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/cart_item_background.dart';
import 'package:ecommerce_app/screens/order_tracking_screen/order_tracking_screen.dart';
import 'package:flutter/material.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel order;
  final OrderProductDetail orderItem;
  final EdgeInsets margin;
  const OrderItemWidget({
    super.key,
    required this.order,
    required this.orderItem,
    this.margin = const EdgeInsets.symmetric(
        horizontal: AppDimensions.defaultPadding, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => _navigateToOrderTrackingScreen(context),
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
                  const Text(
                    "Vado Odelle Dress",
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
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: orderItem.color.toColor(),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      )
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

  void _navigateToOrderTrackingScreen(BuildContext context) {
    Navigator.pushNamed(context, OrderTrackingScreen.routeName,
        arguments: OrderTrackingArguments(order: order, orderItem: orderItem));
  }
}

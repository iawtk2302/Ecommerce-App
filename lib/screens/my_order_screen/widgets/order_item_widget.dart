import 'package:ecommerce_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/common_widgets/color_dot_widget.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/order_product_detail.dart';
import 'package:ecommerce_app/repositories/cart_repository.dart';
import 'package:ecommerce_app/repositories/review_repository.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/cart_item_background.dart';
import 'package:ecommerce_app/screens/my_order_screen/widgets/write_review_bottom_sheet.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel order;
  final OrderProductDetail orderItem;
  final EdgeInsets margin;
  final VoidCallback? onTap;
  final bool isComplete;

  const OrderItemWidget({
    super.key,
    required this.order,
    required this.orderItem,
    this.margin = const EdgeInsets.symmetric(
        horizontal: AppDimensions.defaultPadding, vertical: 10),
    this.onTap,
    this.isComplete = false,
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
            Column(
              children: [
                Text(
                  orderItem.productPrice.toPriceString(),
                  style: AppStyles.headlineLarge,
                ),
                if (isComplete && orderItem.review == null)
                  MyButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      onPressed: () => _onWriteReview(context),
                      child: Text("Review",
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.whiteColor,
                          ))),
                if (isComplete && orderItem.review != null)
                  MyButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      onPressed: () => _onAddToCart(context),
                      child: Text("Buy again",
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.whiteColor,
                          ))),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onWriteReview(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        builder: (_) {
          return WriteReviewBottomSheet(
            orderItem: orderItem,
            onAddReview: (rating, content) async {
              await ReviewRepository().addReview(
                  context: context,
                  orderId: order.id,
                  orderItemId: orderItem.id,
                  productId: orderItem.productId,
                  rating: rating,
                  content: content ?? "");
            },
          );
        });
  }

  void _onAddToCart(BuildContext context) async {
    CartRepository()
        .addCartItem(
            productId: orderItem.productId,
            size: orderItem.size,
            color: orderItem.color,
            quantity: 1)
        .then((value) {
      context.read<CartBloc>().add(LoadCart());
      _showNotification(context);
    });
  }

  void _showNotification(BuildContext context) {
    Utils.showSnackBarSuccess(
      context: context,
      message: "The product has been added to cart.",
      title: "Success",
    );
  }
}

import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';

class PlaceOrderProductItems extends StatelessWidget {
  const PlaceOrderProductItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (_, index) {
          return const CartItemWidget(
            imageWidth: 60,
            imageHeight: 60,
            isAdjustable: false,
          );
        });
  }
}

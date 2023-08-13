import 'package:ecommerce_app/screens/cart_screen/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';

class CartList extends StatelessWidget {
  final EdgeInsets? padding;
  const CartList({
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: padding,
          itemCount: 10,
          itemBuilder: (_, index) {
            return const CartItemWidget();
          }),
    );
  }
}

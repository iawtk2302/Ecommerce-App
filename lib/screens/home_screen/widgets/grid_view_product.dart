import 'package:ecommerce_app/screens/home_screen/widgets/product_item.dart';
import 'package:flutter/material.dart';

class GridViewProduct extends StatelessWidget {
  const GridViewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / 1.6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2),
      itemCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return const ProductItem();
      },
    );
  }
}

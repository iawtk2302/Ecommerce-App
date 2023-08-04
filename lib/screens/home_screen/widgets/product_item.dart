import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 300,
      width: size.width * 0.4,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(),
          )
        ],
      ),
    );
  }
}

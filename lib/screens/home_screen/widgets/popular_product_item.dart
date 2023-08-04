import 'package:flutter/material.dart';

class PopularProductItem extends StatelessWidget {
  const PopularProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        height: size.height * 0.13,
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(),
            )
          ],
        ),
      ),
    );
  }
}

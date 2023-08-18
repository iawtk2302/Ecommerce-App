import 'package:flutter/material.dart';

class ColorDotWidget extends StatelessWidget {
  final Color color;
  final double height;
  final double width;

  const ColorDotWidget(
      {super.key, required this.color, this.height = 10, this.width = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

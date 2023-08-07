import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/color_item.dart';
import 'package:flutter/material.dart';

class ColorBar extends StatefulWidget {
  const ColorBar({super.key});

  @override
  State<ColorBar> createState() => _ColorBarState();
}

class _ColorBarState extends State<ColorBar> {
  List<String> allColors = [
    '#42f5c2',
    '#42f5e3',
    '#42d1f5',
    '#c242f5',
    '#42f5c2',
    '#42f5e3',
  ];
  int visibleSizeCount = 4;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<ColorItem> items = List.generate(
        allColors.length,
        (index) => ColorItem(
              color: allColors[index],
              isSelected: false,
              padding: const EdgeInsets.all(0),
            ));
    if (allColors.length > 4) {
      return Container(
        width: size.width * 0.35,
        height: size.width * 0.12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width * 0.12 / 2),
            border: Border.all(width: 1, color: AppColors.greyColor)),
        child: Row(
          children: [
            const SizedBox(
              width: 4,
            ),
            SizedBox(
              height: size.width * 0.06,
              width: size.width * 0.06 * 4 + 4 * 3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: allColors.length,
                itemBuilder: (context, index) {
                  return ColorItem(
                    color: allColors[index],
                    isSelected: false,
                    padding: const EdgeInsets.only(right: 4),
                  );
                },
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 20,
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: size.width * 0.35,
        height: size.width * 0.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width * 0.12 / 2),
            border: Border.all(width: 1, color: AppColors.greyColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items,
        ),
      );
    }
  }
}

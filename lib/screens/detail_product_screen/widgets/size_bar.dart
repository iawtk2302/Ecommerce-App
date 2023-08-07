import 'package:ecommerce_app/screens/detail_product_screen/widgets/size_item.dart';
import 'package:flutter/material.dart';

class SizeBar extends StatefulWidget {
  const SizeBar({super.key});

  @override
  State<SizeBar> createState() => _SizeBarState();
}

class _SizeBarState extends State<SizeBar> {
  List<String> allSizes = ['S', 'M', 'L', 'XL', 'XXL'];
  int visibleSizeCount = 3;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.width * 0.12,
      width: size.width * 0.12 * 3 + 10 * 3 + 24,
      child: Row(
        children: [
          SizedBox(
            height: size.width * 0.12,
            width: size.width * 0.12 * 3 + 10 * 3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allSizes.length,
              itemBuilder: (context, index) {
                return SizeItem(value: allSizes[index], isSelected: false);
              },
            ),
          ),
          const Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}

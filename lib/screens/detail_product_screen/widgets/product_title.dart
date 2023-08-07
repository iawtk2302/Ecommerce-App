import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "On Ear Headphone",
                style: AppStyles.headlineLarge,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Beats Solo3 Wireless",
                style: AppStyles.bodyLarge,
              ),
            ],
          ),
          Container(
            height: size.height * 0.05,
            decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.remove)),
                const Text("1"),
                IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

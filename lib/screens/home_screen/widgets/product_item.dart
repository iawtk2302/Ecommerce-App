import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/my_icon_button.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/screens/detail_product_screen/detail_product_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightItem =
        (size.width - 2 * AppDimensions.defaultPadding - 10) / 2 * 1.6 * 7 / 10;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailProductScreen.routeName);
      },
      child: Column(
        children: [
          Container(
            height: heightItem,
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/5b0981ff-45f8-40c3-9372-32430a62aaea/dunk-high-womens-shoes-PXHcGT.png"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: MyIconButton(
                size: 30,
                color: AppColors.primaryColor,
                onPressed: () {},
                icon: const MyIcon(
                  icon: AppAssets.icHeartOutline,
                ),
              ),
            ),
          ),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Roll Rabbit",
                  style: AppStyles.labelLarge,
                ),
                Text(
                  "Vado Odelle Dress",
                  style: AppStyles.bodyMedium,
                ),
                Text(
                  "\$198.00",
                  style: AppStyles.labelLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/product_item.dart';
import 'package:flutter/material.dart';

class NewArrivalsHome extends StatelessWidget {
  const NewArrivalsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "New Arrivals",
                    style: AppStyles.titleMedium,
                  ),
                  Text(
                    "View All",
                    style: AppStyles.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600),
                  )
                ]),
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2 / 3.3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: 10,
            // scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ProductItem();
            },
          ),
        ],
      ),
    );
  }
}

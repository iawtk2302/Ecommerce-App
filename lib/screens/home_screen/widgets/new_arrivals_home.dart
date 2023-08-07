import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/grid_view_product.dart';
import 'package:flutter/material.dart';

class NewArrivalsHome extends StatelessWidget {
  const NewArrivalsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.defaultPadding, vertical: 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
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
          const GridViewProduct()
        ],
      ),
    );
  }
}

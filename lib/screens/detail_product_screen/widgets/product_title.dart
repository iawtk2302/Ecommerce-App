import 'package:ecommerce_app/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.brand,
                  style: AppStyles.headlineLarge,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  product.name,
                  style: AppStyles.bodyLarge,
                ),
              ],
            ),
          ),
          Flexible(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                final currentState = state as ProductLoaded;
                return Container(
                  height: size.height * 0.05,
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                      color: AppColors.greyColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            context
                                .read<ProductBloc>()
                                .add(const DecreaseQuantity());
                          },
                          child: const Icon(Icons.remove)),
                      Text(currentState.quantity.toString()),
                      GestureDetector(
                          onTap: () {
                            context
                                .read<ProductBloc>()
                                .add(const IncreaseQuantity());
                          },
                          child: const Icon(Icons.add)),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

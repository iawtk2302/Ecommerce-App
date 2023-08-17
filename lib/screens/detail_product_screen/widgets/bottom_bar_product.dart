import 'package:ecommerce_app/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBarProduct extends StatelessWidget {
  const BottomBarProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Container(
          color: AppColors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.07,
                  width: size.height * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.greyColor),
                  child: const Center(
                    child: MyIcon(
                      icon: AppAssets.icHeartOutline,
                      colorFilter: ColorFilter.mode(
                          AppColors.primaryColor, BlendMode.srcIn),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<ProductBloc>().add(const AddToCart());
                  },
                  child: Container(
                    height: size.height * 0.07,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        const MyIcon(icon: AppAssets.icBag),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Add to cart",
                          style: AppStyles.headlineMedium
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

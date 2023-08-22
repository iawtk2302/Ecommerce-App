import 'package:ecommerce_app/blocs/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/repositories/promotion_repository.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/promotion_item.dart';
import 'package:ecommerce_app/screens/promotion_screen/promotion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromotionsHome extends StatelessWidget {
  const PromotionsHome({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final currentState = state as HomeLoaded;
        return Padding(
          padding: const EdgeInsets.only(left: AppDimensions.defaultPadding),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                      currentState.promotions.length + 1,
                      (index) => index < currentState.promotions.length
                          ? PromotionItem(
                              height: size.height * 0.2,
                              width: size.width * 0.7,
                              promotion: currentState.promotions[index],
                              onGetPromotion: () {
                                PromotionRepository().addToMyPromotions(
                                    promotion: currentState.promotions[index]);
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PromotionScreen.routeName);
                                },
                                child: Container(
                                  height: size.height * 0.2,
                                  width: size.width * 0.09,
                                  decoration: BoxDecoration(
                                      color: AppColors.greyColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(Icons.chevron_right),
                                ),
                              ),
                            )))),
        );
      },
    );
  }
}

import 'package:ecommerce_app/blocs/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/promotion_item.dart';
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
                      currentState.promotions.length,
                      (index) => PromotionItem(
                            height: size.height * 0.2,
                            width: size.width * 0.7,
                            promotion: currentState.promotions[index],
                          )))),
        );
      },
    );
  }
}

import 'package:ecommerce_app/blocs/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/popular_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularHome extends StatelessWidget {
  const PopularHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final currentState = state as HomeLoaded;
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.defaultPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Popular",
                        style: AppStyles.titleMedium,
                      ),
                      Text(
                        "View All",
                        style: AppStyles.bodyMedium
                            .copyWith(fontWeight: FontWeight.w600),
                      )
                    ]),
              ),
              ListView.builder(
                itemCount: currentState.popular.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return PopularProductItem(
                    product: currentState.popular[index],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/promotion.dart';
import 'package:ecommerce_app/repositories/promotion_repository.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/promotion_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoosePromotionScreen extends StatelessWidget {
  const ChoosePromotionScreen({super.key});

  static const String routeName = "/choose-promotion-screen";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const ScreenNameSection(label: "Discount Offer"),
        FutureBuilder<List<Promotion>>(
            future: PromotionRepository().fetchPromotions(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CustomLoadingWidget();
              }
              final List<Promotion> promotions = snapshot.data!;
              return Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.defaultPadding),
                    shrinkWrap: true,
                    itemCount: promotions.length,
                    separatorBuilder: (_, index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (_, index) {
                      return PromotionItem(
                        promotion: promotions[index],
                        width: size.width - 2 * AppDimensions.defaultPadding,
                        height: size.height * 0.2,
                        onGetPromotion: () => _onGetPromotion(
                            context: context, promotion: promotions[index]),
                      );
                    }),
              );
            })
      ]),
    );
  }

  _onGetPromotion(
      {required BuildContext context, required Promotion promotion}) {
    context.read<PlaceOrderBloc>().add(UpdatePromotion(promotion));
    Navigator.pop(context);
  }
}

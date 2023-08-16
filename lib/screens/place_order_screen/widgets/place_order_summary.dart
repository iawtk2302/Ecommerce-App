import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:ecommerce_app/screens/payment_screen/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceOrderSummary extends StatelessWidget {
  const PlaceOrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.defaultPadding, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Total price", style: AppStyles.bodyMedium),
              BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
                builder: (context, state) {
                  return Text(
                    state.totalPrice?.toPriceString() ?? "",
                    style: AppStyles.headlineLarge,
                  );
                },
              )
            ],
          ),
          MyButton(
              child: Text("Place Order",
                  style: AppStyles.labelLarge
                      .copyWith(color: AppColors.whiteColor)),
              onPressed: () => _navigateToPaymentScreen(context))
        ],
      ),
    );
  }

  _navigateToPaymentScreen(BuildContext context) {
    Navigator.pushNamed(context, PaymentScreen.routeName);
  }
}

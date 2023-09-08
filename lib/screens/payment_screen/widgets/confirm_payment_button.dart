import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/models/payment_method_resource.dart';
import 'package:ecommerce_app/screens/order_processing_screen/order_processing_screen.dart';
import 'package:ecommerce_app/utils/passcode_utils.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPaymentButton extends StatelessWidget {
  const ConfirmPaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
      builder: (context, state) {
        return MyButton(
            margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.defaultPadding, vertical: 20),
            onPressed: () => _onPayment(
                context: context, selectedMethod: state.paymentMethod),
            isEnable: state.paymentMethod != null,
            child: Text(
              "Confirm payment",
              style: AppStyles.labelLarge.copyWith(color: AppColors.whiteColor),
            ));
      },
    );
  }

  Future<void> _onPayment(
      {required BuildContext context,
      required PaymentMethodResource? selectedMethod}) async {
    if (selectedMethod != null) {
      PasscodeUtils().getPasscode().then((passcode) {
        if (passcode != null) {
          Utils().showEnterPasscodeBottomSheet(
            context: context,
            passcode: passcode,
            onTruePasscode: () => _onTruePasscode(context: context),
          );
        }
      });
    }
  }

  _onTruePasscode({required BuildContext context}) async {
    try {
      Utils().showPayingDialog(context: context);

      Future.delayed(const Duration(seconds: 2))
          .then((value) => Navigator.pushNamedAndRemoveUntil(
                context,
                OrderProcessingScreen.routeName,
                (route) => route.isFirst,
              ));
    } catch (e) {
      Utils.showSnackBar(context: context, message: "Something went wrong");
    }
  }
}

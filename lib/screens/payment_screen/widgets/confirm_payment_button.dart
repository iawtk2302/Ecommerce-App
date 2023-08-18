import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/models/payment_method.dart';
import 'package:ecommerce_app/screens/order_processing_screen/order_processing_screen.dart';
import 'package:ecommerce_app/utils/local_auth_utils.dart';
import 'package:ecommerce_app/utils/passcode_utils.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

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
      required PaymentMethod? selectedMethod}) async {
    if (selectedMethod != null) {
      PasscodeUtils().getPasscode().then((passcode) {
        showModalBottomSheet(
          context: context,
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Enter your passcode",
                    style: AppStyles.labelLarge,
                  ),
                  const SizedBox(height: 20),
                  Pinput(
                    validator: (value) {
                      if (value != passcode) {
                        return "Wrong passcode";
                      }
                      return null;
                    },
                    autofocus: true,
                    length: 6,
                    obscureText: true,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    onCompleted: (value) {
                      if (value == passcode) {
                        _onTruePasscode(context: context);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<bool>(
                      future: LocalAuthUtil().isBiometricsAvailable(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data == true) {
                            return InkWell(
                              onTap: () {
                                LocalAuthUtil()
                                    .authenticateWithBiometrics()
                                    .then((value) {
                                  if (value) {
                                    _onTruePasscode(context: context);
                                  } else {
                                    Utils.showSnackBar(
                                        context: context,
                                        message:
                                            "Your device does not support");
                                  }
                                });
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyIcon(icon: AppAssets.icFingerprint),
                                  SizedBox(width: 10),
                                  Text("Use fingerprint"),
                                ],
                              ),
                            );
                          }
                        }
                        return const SizedBox();
                      })
                ],
              ),
            );
          },
        );
      });
    }
  }

  _onTruePasscode({required BuildContext context}) async {
    try {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Lottie.asset(AppAssets.lottieTransactionProcess),
            ),
          );
        },
      );

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

import 'package:ecommerce_app/blocs/payment_methods_bloc/payment_methods_bloc.dart';
import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/models/payment_card.dart';
import 'package:ecommerce_app/repositories/payment_methods_repository.dart';
import 'package:ecommerce_app/screens/payment_screen/widgets/payment_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  static const String routeName = "/payment-screen";

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedMethod;

  @override
  void initState() {
    super.initState();
    context.read<PaymentMethodsBloc>().add(LoadPaymentMethods());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ScreenNameSection(label: "Payment"),
          BlocBuilder<PaymentMethodsBloc, PaymentMethodsState>(
            builder: (context, state) {
              if (state is PaymentMethodsLoading) {
                return const Center(child: CustomLoadingWidget());
              } else if (state is PaymentMethodsError) {
                return const Text("Something went wrong");
              } else if (state is PaymentMethodsLoaded) {
                final List<PaymentCard> paymentCards = state.paymentCards;
                return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.defaultPadding),
                    shrinkWrap: true,
                    itemCount: paymentMethods.length,
                    itemBuilder: (_, index) {
                      PaymentCard? thisCard;
                      final tempLst = paymentCards.where((element) =>
                          element.cardType == paymentMethods[index].code);
                      thisCard = tempLst.isEmpty ? null : tempLst.first;

                      return PaymentItemCard(
                          isSelected:
                              selectedMethod == paymentMethods[index].code,
                          paymentMethod: paymentMethods[index],
                          paymentCard: thisCard,
                          onTap: () {
                            if (thisCard != null ||
                                paymentMethods[index].code ==
                                    "cash_on_delivery") {
                              setState(() {
                                selectedMethod = paymentMethods[index].code;
                              });
                            }
                          });
                    });
              } else {
                return const SizedBox();
              }
            },
          ),
          const Spacer(),
          MyButton(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding, vertical: 20),
              onPressed: () {},
              child: Text(
                "Confirm payment",
                style:
                    AppStyles.labelLarge.copyWith(color: AppColors.whiteColor),
              ))
        ],
      ),
    );
  }
}

import 'package:ecommerce_app/blocs/payment_methods_bloc/payment_methods_bloc.dart';
import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/payment_information.dart';
import 'package:ecommerce_app/repositories/payment_methods_repository.dart';
import 'package:ecommerce_app/screens/payment_screen/widgets/confirm_payment_button.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<PaymentMethodsBloc>().add(LoadPaymentMethods());
    context
        .read<PlaceOrderBloc>()
        .add(const UpdatePaymentInformation(paymentMethod: null)); //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
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
                  final List<PaymentInformation> paymentCards =
                      state.paymentCards;
                  return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.defaultPadding),
                      shrinkWrap: true,
                      itemCount: paymentMethods.length,
                      itemBuilder: (_, index) {
                        PaymentInformation? thisPaymentInformation;
                        final tempLst = paymentCards.where((element) =>
                            element.type == paymentMethods[index].code);
                        thisPaymentInformation =
                            tempLst.isNotEmpty ? tempLst.first : null;

                        return BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
                          builder: (context, state) {
                            return PaymentItemCard(
                                isSelected: state.paymentMethod?.code ==
                                    paymentMethods[index].code,
                                paymentMethod: paymentMethods[index],
                                paymentCard: thisPaymentInformation,
                                onTap: () {
                                  if (thisPaymentInformation != null) {
                                    context.read<PlaceOrderBloc>().add(
                                        UpdatePaymentInformation(
                                            paymentInformation:
                                                thisPaymentInformation,
                                            paymentMethod:
                                                paymentMethods[index]));
                                  } else if (paymentMethods[index].code ==
                                      "cash_on_delivery") {
                                    context.read<PlaceOrderBloc>().add(
                                        UpdatePaymentInformation(
                                            paymentMethod:
                                                paymentMethods[index]));
                                  }
                                });
                          },
                        );
                      });
                } else {
                  return const SizedBox();
                }
              },
            ),
            const ConfirmPaymentButton(),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/blocs/order_processing_bloc/order_processing_bloc.dart';
import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/common_widgets/my_outlined_button.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/order_status.dart';
import 'package:ecommerce_app/models/order_summary.dart';
import 'package:ecommerce_app/screens/order_tracking_screen/order_tracking_screen.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';
import 'package:ecommerce_app/utils/order_util.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class OrderProcessingScreen extends StatefulWidget {
  const OrderProcessingScreen({
    super.key,
  });

  static const String routeName = "/order-processing-screen";

  @override
  State<OrderProcessingScreen> createState() => _OrderProcessingScreenState();
}

class _OrderProcessingScreenState extends State<OrderProcessingScreen> {
  @override
  void initState() {
    super.initState();
    _addOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<OrderProcessingBloc, OrderProcessingState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 50),
                // Icon section
                if (state is OrderProcessingSuccessfully)
                  Lottie.asset(AppAssets.lottieSuccess,
                      height: 300, width: 300),
                if (state is OrderProcessingFailed)
                  Lottie.asset(AppAssets.lottieFail, height: 300, width: 300),
                if (state is OrderProcessingAdding)
                  Lottie.asset(AppAssets.lottieWaiting,
                      height: 300, width: 300),
                const SizedBox(height: 20),

                // Description section
                if (state is OrderProcessingSuccessfully)
                  const Text("Order successfully",
                      style: AppStyles.displayMedium),
                if (state is OrderProcessingFailed)
                  const Text("Order failed. Please try again.",
                      style: AppStyles.displayMedium),
                if (state is OrderProcessingAdding)
                  const Text("Waiting...", style: AppStyles.displayMedium),
                const Spacer(),

                // Actions section
                if (state is OrderProcessingSuccessfully)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.defaultPadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyOutlinedButton(
                              onPressed: () =>
                                  _navigateToOrderTrackingScreen(state.order),
                              child: const Row(
                                children: [
                                  Text("View order",
                                      style: AppStyles.labelLarge),
                                ],
                              )),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: MyButton(
                            onPressed: () {
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            },
                            borderRadius: 12,
                            child: Text(
                              "Home",
                              style: AppStyles.labelLarge.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (state is OrderProcessingFailed)
                  MyOutlinedButton(
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.defaultPadding),
                      onPressed: _onFailBackButton,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Back", style: AppStyles.labelLarge),
                        ],
                      )),
                const SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }

  _addOrder() {
    final placeOrderState = context.read<PlaceOrderBloc>().state;
    final userState = context.read<UserBloc>().state;
    if (userState is UserLoaded) {
      final user = userState.user;

      final OrderModel order = OrderModel(
          id: "",
          orderNumber:
              OrderUtil().generateOrderNumber(firebaseAuth.currentUser!.uid),
          customerId: firebaseAuth.currentUser!.uid,
          customerName: user.name,
          address: placeOrderState.address!,
          orderSummary: OrderSummary(
            amount: placeOrderState.amount!,
            shipping: placeOrderState.shipping!,
            promotionDiscount: placeOrderState.promoDiscount!,
            total: placeOrderState.totalPrice!,
          ),
          isCompleted: false,
          paymentMethod: placeOrderState.paymentMethod!.code,
          isPayed: placeOrderState.paymentMethod!.code == "cash_on_delivery"
              ? false
              : false,
          currentOrderStatus: OrderStatus.pending,
          createdAt: Timestamp.fromDate(DateTime.now()));
      context
          .read<OrderProcessingBloc>()
          .add(AddOrder(order: order, items: placeOrderState.cart!.cartItems));
    } else {
      Utils.showSnackBar(
          context: context, message: "Something went wrong. Please try again.");
    }
  }

  _onFailBackButton() {
    Navigator.pop(context);
    context.read<OrderProcessingBloc>().add(ResetOrderProcessingState());
  }

  _navigateToOrderTrackingScreen(OrderModel order) {
    Navigator.pushNamed(context, OrderTrackingScreen.routeName,
        arguments: order);
  }
}

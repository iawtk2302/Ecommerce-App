import 'package:ecommerce_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/promotion.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/cart_item_background.dart';
import 'package:ecommerce_app/screens/place_order_screen/widgets/place_order_bill_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceOrderBill extends StatefulWidget {
  const PlaceOrderBill({super.key});

  @override
  State<PlaceOrderBill> createState() => _PlaceOrderBillState();
}

class _PlaceOrderBillState extends State<PlaceOrderBill> {
  // double amount = 0;
  // double shipping = 15;
  // double promo = 0;
  // double total = 0;

  @override
  void initState() {
    super.initState();
    _getStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return CartItemBackground(
        margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding, vertical: 10),
        padding: const EdgeInsets.all(AppDimensions.defaultPadding),
        child: BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
          builder: (context, state) {
            return Column(
              children: [
                PlaceOrderBillLine(
                  label: "Amount",
                  number: "\$${state.amount}",
                ),
                const SizedBox(height: 10),
                PlaceOrderBillLine(
                  label: "Shipping",
                  number: "\$${state.shipping}",
                ),
                const SizedBox(height: 10),
                PlaceOrderBillLine(
                    label: "Promo", number: "\$${state.promoDiscount}"),
                const SizedBox(height: 5),
                const Divider(),
                const SizedBox(height: 5),
                PlaceOrderBillLine(
                  label: "Total",
                  number: "\$${state.totalPrice}",
                ),
              ],
            );
          },
        ));
  }

  _getStatistics() {
    final cartState = context.read<CartBloc>().state;
    if (cartState is CartLoaded) {
      print("Cart loaded");
      context.read<PlaceOrderBloc>().add(GetBill(cart: cartState.cart));
    }
    // if (cartState is CartLoaded) {
    //   amount = cartState.cart.totalPrice;
    // }
    // final placeOrderState = context.read<PlaceOrderBloc>().state;
    // if (placeOrderState.promotion is FreeShippingPromotion) {
    //   shipping = 0;
    // } else if (placeOrderState.promotion is PercentagePromotion) {
    //   promo = amount *
    //       (placeOrderState.promotion as PercentagePromotion).percentage /
    //       100;
    // } else if (placeOrderState.promotion is FixedAmountPromotion) {
    //   promo = (placeOrderState.promotion as FixedAmountPromotion).amount;
    // } else {
    //   shipping = placeOrderState.defaultShipping;
    //   promo = 0;
    // }
    // total = amount + shipping - promo;
  }

  // _updateStatistics() {
  //   final placeOrderState = context.read<PlaceOrderBloc>().state;
  //   if (placeOrderState.promotion is FreeShippingPromotion) {
  //     setState(() {
  //       shipping = 0;
  //       promo = 0;
  //     });
  //   } else if (placeOrderState.promotion is PercentagePromotion) {
  //     setState(() {
  //       promo = amount *
  //           (placeOrderState.promotion as PercentagePromotion).percentage /
  //           100;
  //     });
  //   } else if (placeOrderState.promotion is FixedAmountPromotion) {
  //     setState(() {
  //       promo = (placeOrderState.promotion as FixedAmountPromotion).amount;
  //     });
  //   } else {
  //     setState(() {
  //       shipping = placeOrderState.defaultShipping;
  //       promo = 0;
  //     });
  //   }
  //   setState(() {
  //     total = amount + shipping - promo;
  //   });
  // }
}

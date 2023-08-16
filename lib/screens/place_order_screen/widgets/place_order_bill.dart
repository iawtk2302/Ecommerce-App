import 'package:ecommerce_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
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
                  number: "${state.amount?.toPriceString()}",
                ),
                const SizedBox(height: 10),
                PlaceOrderBillLine(
                  label: "Shipping",
                  number: "${state.shipping?.toPriceString()}",
                ),
                const SizedBox(height: 10),
                PlaceOrderBillLine(
                    label: "Promo",
                    number: "${state.promoDiscount?.toPriceString()}"),
                const SizedBox(height: 5),
                const Divider(),
                const SizedBox(height: 5),
                PlaceOrderBillLine(
                  label: "Total",
                  number: "${state.totalPrice?.toPriceString()}",
                ),
              ],
            );
          },
        ));
  }

  _getStatistics() {
    final cartState = context.read<CartBloc>().state;
    if (cartState is CartLoaded) {
      context.read<PlaceOrderBloc>().add(GetBill(cart: cartState.cart));
    }
  }
}

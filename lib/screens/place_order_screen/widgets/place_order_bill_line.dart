import 'package:ecommerce_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceOrderBillLine extends StatelessWidget {
  final String label;
  final String number;

  const PlaceOrderBillLine({
    super.key,
    required this.label,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoaded) {
              return Text(number);
            }
            return const SizedBox();
          },
        )
      ],
    );
  }
}

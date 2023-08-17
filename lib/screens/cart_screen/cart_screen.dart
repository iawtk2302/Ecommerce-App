import 'package:ecommerce_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/common_widgets/cart_button.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/cart_list.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/summary_section.dart';
import 'package:ecommerce_app/screens/my_order_screen/my_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        hideDefaultLeadingButton: true,
        actions: [
          CartButton(
              onTap: () =>
                  Navigator.pushNamed(context, MyOrderScreen.routeName)),
        ],
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenNameSection(
            label: "My Cart",
          ),
          CartList(
            padding:
                EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
          ),
          SummarySection(
            margin: EdgeInsets.symmetric(
                horizontal: AppDimensions.defaultPadding, vertical: 15),
          ),
        ],
      ),
    );
  }
}

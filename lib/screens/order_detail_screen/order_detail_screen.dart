import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  static const String routeName = "/order-detail-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}

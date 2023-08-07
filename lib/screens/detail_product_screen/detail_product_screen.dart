import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/bottom_bar_product.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/product_description.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/product_image.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/product_size.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/product_title.dart';
import 'package:flutter/material.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key});
  static const String routeName = '/detail-product-screen';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProductImage(),
                ProductTile(),
                ProductDescription(),
                ProductSize(),
                BottomBarProduct()
              ],
            ),
          )),
    );
  }
}

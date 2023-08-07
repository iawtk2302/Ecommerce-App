import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/grid_view_product.dart';
import 'package:flutter/material.dart';

class CategoryProductScreen extends StatelessWidget {
  const CategoryProductScreen({super.key});
  static const String routeName = '/category-product-screen';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ScreenNameSection(
                label: "Clothes",
              ),
              GridViewProduct()
            ],
          ),
        ));
  }
}

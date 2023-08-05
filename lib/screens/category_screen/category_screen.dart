import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_body_scaffold.dart';
import 'package:ecommerce_app/screens/category_screen/widgets/grid_view_catogory.dart';
import 'package:ecommerce_app/screens/category_screen/widgets/search_category_bar.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  static const String routeName = '/category-screen';
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> ui = [const SearchCategoryBar(), GridViewCategory()];
    return Scaffold(
        appBar: const MyAppBar(),
        body: MyBodyScaffold(
          widgets: ui,
        ));
  }
}

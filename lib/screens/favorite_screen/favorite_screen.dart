import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/repositories/favorite_repository.dart';
import 'package:ecommerce_app/screens/favorite_screen/empty_product.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/grid_view_product.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    super.key,
  });

  static const String routeName = '/favorite-screen';

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: FutureBuilder<List<Product>>(
          future: FavoriteRepository().fetchProducts(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoadingWidget();
            } else if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ScreenNameSection(
                            label: 'Favorite Products',
                          ),
                          GridViewProduct(
                            products: snapshot.data!,
                            productCount: snapshot.data!.length,
                          )
                        ],
                      ),
                    )
                  : const EmptyProduct();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}

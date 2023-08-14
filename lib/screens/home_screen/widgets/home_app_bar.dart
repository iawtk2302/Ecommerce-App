import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/category_screen/category_screen.dart';
import 'package:ecommerce_app/screens/search_screen/custom_search_delegate.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.height, required this.isScrolled});
  final double height;
  final bool isScrolled;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _navigateCategoryScreen(context),
              child: const CircleAvatar(
                backgroundColor: Colors.black,
                radius: 18,
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
            ),
            !isScrolled
                ? const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://nld.mediacdn.vn/291774122806476800/2023/5/17/3471044557860853628333446226731026240094406n-16842998525331526811843.jpg"),
                    radius: 22,
                  )
                : IconButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: CustomSearchDelegate());
                    },
                    icon: Icon(
                      Icons.search,
                      size: 30,
                    )),
          ],
        ),
      ),
    );
  }

  _navigateCategoryScreen(BuildContext context) {
    Navigator.pushNamed(context, CategoryScreen.routeName);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}

import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, required this.height, required this.isScrolled});
  final double height;
  final bool isScrolled;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(height),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.defaultPadding, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.black,
                radius: 22,
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              !isScrolled
                  ? const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://nld.mediacdn.vn/291774122806476800/2023/5/17/3471044557860853628333446226731026240094406n-16842998525331526811843.jpg"),
                      radius: 22,
                    )
                  : const Icon(
                      Icons.search,
                      size: 30,
                    ),
            ],
          ),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}

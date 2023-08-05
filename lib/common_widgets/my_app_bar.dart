import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/my_ink_well_icon_button.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, this.actions});
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding, vertical: 10),
        child: Row(
          children: [
            MyInkWellIconButton(
                onTap: () => _navigatePreviousScreen(context),
                radius: 35 / 2,
                icon: const MyIcon(
                  icon: AppAssets.icArrowLeft,
                ),
                color: AppColors.primaryColor),
            const Spacer(),
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }

  _navigatePreviousScreen(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

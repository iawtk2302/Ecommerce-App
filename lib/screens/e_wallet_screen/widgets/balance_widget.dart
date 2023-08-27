import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/screens/top_up_screen/top_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your balance",
              style:
                  AppStyles.titleSmall.copyWith(color: AppColors.whiteColor)),
          const SizedBox(height: 10),
          Row(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return Text(
                    "\$${(state is UserLoaded) ? state.user.eWalletBalance : 0}",
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  );
                },
              ),
              const Spacer(),
              MyButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  backgroundColor: AppColors.whiteColor,
                  onPressed: () => _navigateToTopUpScreen(context),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyIcon(icon: AppAssets.icTopUp, height: 16),
                      SizedBox(width: 5),
                      Text("Top Up", style: AppStyles.titleSmall)
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToTopUpScreen(BuildContext context) {
    Navigator.pushNamed(context, TopUpScreen.routeName);
  }
}

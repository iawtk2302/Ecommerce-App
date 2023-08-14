import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/common_widgets/address_card.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/my_outlined_button.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/screens/add_address_screen/add_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseAddressScreen extends StatelessWidget {
  const ChooseAddressScreen({super.key});

  static const String routeName = "/choose-address-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.user.shippingAddresses.length,
                      separatorBuilder: (_, index) {
                        return const SizedBox(height: 10);
                      },
                      itemBuilder: (_, index) {
                        final address = state.user.shippingAddresses[index];
                        return InkWell(
                            onTap: () => _onChooseAddress(
                                context: context, address: address),
                            child: AddressCard(defaultAddress: address));
                      });
                } else {
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(height: 30),
            MyOutlinedButton(
                onPressed: () => _navigateToAddAddressScreen(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyIcon(icon: AppAssets.icAddRound),
                    const SizedBox(width: 10),
                    Text(
                      "Add New Address",
                      style: AppStyles.labelLarge
                          .copyWith(color: AppColors.primaryColor),
                    )
                  ],
                )),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  _navigateToAddAddressScreen(BuildContext context) {
    Navigator.pushNamed(context, AddAddressScreen.routeName);
  }

  _onChooseAddress(
      {required BuildContext context, required ShippingAddress address}) {
    context.read<PlaceOrderBloc>().add(UpdateAddress(address));
    Navigator.pop(context);
  }
}

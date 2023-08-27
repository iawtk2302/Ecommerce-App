import 'package:ecommerce_app/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/screens/add_address_screen/add_address_screen.dart';
import 'package:ecommerce_app/common_widgets/primary_background.dart';
import 'package:ecommerce_app/screens/place_order_screen/widgets/address_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AdjustableAddressCard extends StatelessWidget {
  const AdjustableAddressCard({
    super.key,
    required this.address,
  });

  final ShippingAddress address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.15,
          children: [
            SlidableAction(
              autoClose: true,
              onPressed: (context) => _onDeleteAddress(context),
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ],
        ),
        child: PrimaryBackground(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.only(left: 20, top: 30, bottom: 30),
            borderRadius: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddressLine(label: "Street", content: address.street),
                      AddressLine(label: "City", content: address.city),
                      AddressLine(
                          label: "State/province/area", content: address.state),
                      AddressLine(
                          label: "Phone number", content: address.phoneNumber),
                      AddressLine(label: "Zip code", content: address.zipCode),
                      AddressLine(
                          label: "Country calling code",
                          content: address.countryCallingCode),
                      AddressLine(label: "Country", content: address.country),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () => _navigateToEditAddressScreen(context),
                    child: const Text("Edit")),
              ],
            )),
      ),
    );
  }

  void _navigateToEditAddressScreen(BuildContext context) {
    Navigator.pushNamed(context, AddAddressScreen.routeName,
        arguments: address);
  }

  void _onDeleteAddress(BuildContext context) {
    context.read<AddressesBloc>().add(DeleteAddress(addressId: address.id));
  }
}

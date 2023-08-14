import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/cart_item_background.dart';
import 'package:ecommerce_app/screens/place_order_screen/widgets/address_line.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.defaultAddress,
  });

  final ShippingAddress defaultAddress;

  @override
  Widget build(BuildContext context) {
    return CartItemBackground(
        margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        borderRadius: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddressLine(label: "Street", content: defaultAddress.street),
            AddressLine(label: "City", content: defaultAddress.city),
            AddressLine(
                label: "State/province/area", content: defaultAddress.state),
            AddressLine(
                label: "Phone number", content: defaultAddress.phoneNumber),
            AddressLine(label: "Zip code", content: defaultAddress.zipCode),
            AddressLine(
                label: "Country calling code",
                content: defaultAddress.countryCallingCode),
            AddressLine(label: "Country", content: defaultAddress.country),
          ],
        ));
  }
}

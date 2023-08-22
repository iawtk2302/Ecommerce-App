import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/cart_item_background.dart';
import 'package:ecommerce_app/screens/place_order_screen/widgets/address_line.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
  });

  final ShippingAddress address;

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
            AddressLine(label: "Street", content: address.street),
            AddressLine(label: "City", content: address.city),
            AddressLine(label: "State/province/area", content: address.state),
            AddressLine(label: "Phone number", content: address.phoneNumber),
            AddressLine(label: "Zip code", content: address.zipCode),
            AddressLine(
                label: "Country calling code",
                content: address.countryCallingCode),
            AddressLine(label: "Country", content: address.country),
          ],
        ));
  }
}

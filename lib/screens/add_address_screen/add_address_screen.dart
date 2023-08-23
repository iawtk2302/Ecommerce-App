import 'package:ecommerce_app/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:ecommerce_app/common_widgets/fill_information_text_field.dart';
import 'package:ecommerce_app/common_widgets/loading_manager.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/repositories/address_repository.dart';
import 'package:ecommerce_app/screens/add_address_screen/add_address_confirm_button.dart';
import 'package:ecommerce_app/utils/location_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:geolocator/geolocator.dart';

class AddAddressScreen extends StatefulWidget {
  final ShippingAddress? address;

  const AddAddressScreen({
    super.key,
    this.address,
  });

  static const String routeName = "/add-address-screen";

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool isLoading = false;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController callingCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  bool setAsDefaultAddress = true;
  final formState = GlobalKey<FormState>();
  Position? position;

  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      fullNameController.text = widget.address!.recipientName;
      countryController.text = widget.address!.country;
      stateController.text = widget.address!.state;
      cityController.text = widget.address!.city;
      streetController.text = widget.address!.street;
      zipCodeController.text = widget.address!.zipCode;
      callingCodeController.text = widget.address!.countryCallingCode;
      phoneNumberController.text = widget.address!.phoneNumber;
    } else {
      _getPosition();
    }
  }

  @override
  void dispose() {
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    streetController.dispose();
    zipCodeController.dispose();
    callingCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingManager(
      isLoading: isLoading,
      child: Scaffold(
        appBar: const MyAppBar(),
        body: KeyboardDismissOnTap(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScreenNameSection(label: "Add New Address"),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.defaultPadding),
                    child: Form(
                      key: formState,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FillInformationTextField(
                            label: "Full name",
                            controller: fullNameController,
                            validator: _validator,
                          ),
                          FillInformationTextField(
                            label: "Country",
                            controller: countryController,
                            validator: _validator,
                          ),
                          FillInformationTextField(
                            label: "State/Province/Region",
                            controller: stateController,
                            validator: _validator,
                          ),
                          FillInformationTextField(
                            label: "City",
                            controller: cityController,
                            validator: _validator,
                          ),
                          FillInformationTextField(
                            label: "Street",
                            controller: streetController,
                            validator: _validator,
                          ),
                          FillInformationTextField(
                            label: "Zip code",
                            controller: zipCodeController,
                            validator: _validator,
                          ),
                          FillInformationTextField(
                            label: "Country calling code",
                            controller: callingCodeController,
                            validator: _validator,
                          ),
                          FillInformationTextField(
                            label: "Phone number",
                            controller: phoneNumberController,
                            validator: _validator,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: setAsDefaultAddress,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value != null) {
                                        setState(() {
                                          setAsDefaultAddress = value;
                                        });
                                      }
                                    });
                                  }),
                              const Text("Use as default address.")
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AddAddressConfirmButton(onPressed: _onConfirmPressed),
            ],
          ),
        ),
      ),
    );
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This information is required";
    }
    return null;
  }

  _onConfirmPressed() async {
    if (formState.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final ShippingAddress newAddress = ShippingAddress(
        id: widget.address != null ? widget.address!.id : "",
        recipientName: fullNameController.text,
        street: streetController.text,
        city: stateController.text,
        state: cityController.text,
        country: countryController.text,
        zipCode: zipCodeController.text,
        countryCallingCode: callingCodeController.text,
        phoneNumber: phoneNumberController.text,
        latitude: widget.address != null
            ? widget.address!.latitude
            : position?.latitude,
        longitude: widget.address != null
            ? widget.address!.longitude
            : position?.longitude,
      );
      if (widget.address == null) {
        await AddressRepository().addShippingAddress(
          address: newAddress,
          setAsDefault: setAsDefaultAddress,
        );
      } else {
        await AddressRepository().updateShippingAddress(
          address: newAddress,
        );
      }

      if (!mounted) return;
      context.read<AddressesBloc>().add(LoadAddresses());
      Navigator.pop(context);

      setState(() {
        isLoading = false;
      });
    }
  }

  _getPosition() async {
    setState(() {
      isLoading = true;
    });

    position = await LocationUtil().getCurrentPosition(context: context);
    if (position == null) {
      return;
    }
    final location =
        await LocationUtil().getLocationFromLatLng(position: position!);
    countryController.text = location.country ?? "";
    stateController.text = location.administrativeArea ?? "";
    cityController.text = location.locality ?? "";
    streetController.text = location.street ?? "";
    zipCodeController.text = location.postalCode ?? "";

    setState(() {
      isLoading = false;
    });
  }
}

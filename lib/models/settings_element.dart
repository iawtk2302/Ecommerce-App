// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/screens/my_order_screen/my_order_screen.dart';
import 'package:ecommerce_app/screens/personal_details_screen/personal_details_screen.dart';
import 'package:flutter/material.dart';

class SettingsElement {
  final String title;
  final String assetPath;
  final Function(BuildContext) onTap;
  SettingsElement({
    required this.title,
    required this.assetPath,
    required this.onTap,
  });
}

final List<SettingsElement> settingsElements = [
  SettingsElement(
    title: "Personal Details",
    assetPath: AppAssets.icUser,
    onTap: (context) {
      Navigator.pushNamed(context, PersonalDetailsScreen.routeName);
    },
  ),
  SettingsElement(
    title: "My Orders",
    assetPath: AppAssets.icBagBold,
    onTap: (context) {
      Navigator.pushNamed(context, MyOrderScreen.routeName);
    },
  ),
  SettingsElement(
    title: "My Favorites",
    assetPath: AppAssets.icHeartBold,
    onTap: (context) {},
  ),
  SettingsElement(
    title: "Shipping Address",
    assetPath: AppAssets.icTruck,
    onTap: (context) {},
  ),
  SettingsElement(
    title: "My Card",
    assetPath: AppAssets.icCard,
    onTap: (context) {},
  ),
  SettingsElement(
    title: "Settings",
    assetPath: AppAssets.icSetting,
    onTap: (context) {},
  ),
];

final List<SettingsElement> contactSettingsElements = [
  SettingsElement(
      title: "FAQs", assetPath: AppAssets.icInfo, onTap: (context) {}),
  SettingsElement(
      title: "Privacy Policy",
      assetPath: AppAssets.icShieldTick,
      onTap: (context) {}),
  SettingsElement(
      title: "Support", assetPath: AppAssets.icHeadphone, onTap: (context) {}),
  SettingsElement(
      title: "Logout", assetPath: AppAssets.icLogout, onTap: (context) {}),
];

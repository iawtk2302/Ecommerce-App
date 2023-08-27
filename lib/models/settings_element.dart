// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/screens/e_wallet_screen/e_wallet_screen.dart';
import 'package:ecommerce_app/screens/faqs_screen/faqs_screen.dart';
import 'package:ecommerce_app/screens/favorite_screen/favorite_screen.dart';
import 'package:ecommerce_app/screens/my_cards_screen/my_cards_screen.dart';
import 'package:ecommerce_app/screens/my_order_screen/my_order_screen.dart';
import 'package:ecommerce_app/screens/personal_details_screen/personal_details_screen.dart';
import 'package:ecommerce_app/screens/settings_screen/settings_screen.dart';
import 'package:ecommerce_app/screens/shipping_addresses_screen/shipping_addresses_screen.dart';
import 'package:ecommerce_app/utils/utils.dart';
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
    onTap: (context) {
      Navigator.pushNamed(context, FavoriteScreen.routeName);
    },
  ),
  SettingsElement(
    title: "Shipping Address",
    assetPath: AppAssets.icTruck,
    onTap: (context) {
      Navigator.pushNamed(context, ShippingAddressesScreen.routeName);
    },
  ),
  SettingsElement(
    title: "My Card",
    assetPath: AppAssets.icCard,
    onTap: (context) {
      Navigator.pushNamed(context, MyCardsScreen.routeName);
    },
  ),
  SettingsElement(
    title: "E-Wallet",
    assetPath: AppAssets.icWallet,
    onTap: (context) {
      Navigator.pushNamed(context, EWalletScreen.routeName);
    },
  ),
  SettingsElement(
    title: "Settings",
    assetPath: AppAssets.icSetting,
    onTap: (context) {
      Navigator.pushNamed(context, SettingsScreen.routeName);
    },
  ),
];

final List<SettingsElement> contactSettingsElements = [
  SettingsElement(
      title: "FAQs",
      assetPath: AppAssets.icInfo,
      onTap: (context) {
        Navigator.pushNamed(context, FAQsScreen.routeName);
      }),
  SettingsElement(
      title: "Privacy Policy",
      assetPath: AppAssets.icShieldTick,
      onTap: (context) {
        Utils().launchUrl(
            "https://www.termsfeed.com/live/fd3cdd13-7687-478e-8783-d06f5454ee5d");
      }),
  SettingsElement(
      title: "Support", assetPath: AppAssets.icHeadphone, onTap: (context) {}),
  // SettingsElement(
  //     title: "Logout", assetPath: AppAssets.icLogout, onTap: (context) {}),
];

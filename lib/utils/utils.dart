import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static bool isEmailValid(String email) {
    final RegExp regex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
  }

  static void showSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static String isValidPassword(String password) {
    String isValidValue = "valid";

    // Password must be at least 8 characters long
    if (password.length < 8) {
      return "Password must be at least 8 characters long";
    }

    // Password must contain at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }

    // Password must contain at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return "Password must contain at least one lowercase letter";
    }

    // Password must contain at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one digit";
    }

    // Password must contain at least one special character
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return isValidValue;
  }

  Future<bool> isAlreadyUsedOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isAlreadyUsedOnboarding") ?? false;
  }

  Future<void> markAlreadyUsedOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isAlreadyUsedOnboarding", true);
  }

  static Color hexToColor(String color) {
    return Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<bool> getNotificationMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("notificationMode") ?? true;
  }

  Future<void> changeNotificationMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool notificationMode = await getNotificationMode();
    prefs.setBool("notificationMode", !notificationMode);
  }

  Future<bool> getDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("darkMode") ?? false;
  }

  Future<void> changeDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool darkMode = await getDarkMode();
    prefs.setBool("darkMode", !darkMode);
  }
}

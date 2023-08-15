import 'package:ecommerce_app/models/promotion.dart';
import 'package:flutter/material.dart';

extension StringExtensions on String {
  Color toColor() {
    return Color(int.parse(substring(1, 7), radix: 16) + 0xFF000000);
  }

  String formatName() {
    List<String> words = split(' ');
    if (words.length >= 2) {
      return words.sublist(words.length - 2).join(' ');
    } else {
      return this;
    }
  }

  PromotionType toPromotion() {
    switch (this) {
      case "free_shipping":
        return PromotionType.freeShipping;
      case "percentage":
        return PromotionType.percentage;
      case "fixed_amount":
        return PromotionType.fixedAmount;
      default:
        return PromotionType.freeShipping;
    }
  }

  String maskCardNumber() {
    int start = 4;
    int end = length - 4;
    String firstFourDigits = substring(0, start);
    String lastFourDigits = substring(end, length);
    String maskedDigits = '*' * (end - start);

    return "$firstFourDigits$maskedDigits$lastFourDigits";
  }
}

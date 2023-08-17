// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_app/constants/enums/gender.dart';
import 'package:ecommerce_app/models/shipping_address.dart';

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final Gender? gender;
  final int? age;
  final ShippingAddress? defaultShippingAddress;
  // final List<ShippingAddress> shippingAddresses;
  // final List<PaymentInformation> paymentCards;
  // final List<CartItem> cart;
  // final List<Promotion> promotions;

  UserProfile({
    required this.id,
    required this.name,
    this.imageUrl = "",
    required this.gender,
    required this.age,
    required this.email,
    this.defaultShippingAddress,
    // this.shippingAddresses = const [],
    // this.paymentCards = const [],
    // this.cart = const [],
    // this.promotions = const [],
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'gender': gender?.name,
      'age': age,
      'defaultShippingAddress': defaultShippingAddress,
      // 'shippingAddresses': shippingAddresses.map((x) => x.toMap()).toList(),
      // 'paymentCards': [],
      // paymentCards.map((x) => x.toMap()).toList(),
      // 'cart': [],
      // cart.map((x) => x.toMap()).toList(),
      // 'promotions': [],
      // promotions.map((x) => x.toMap()).toList(),
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
      gender: map['gender'] != null
          ? map['gender'] == Gender.male.name
              ? Gender.male
              : map['gender'] == Gender.female.name
                  ? Gender.female
                  : Gender.other
          : null,
      age: map['age'] != null ? map['age'] as int : null,
      defaultShippingAddress: map['defaultShippingAddress'] != null
          ? ShippingAddress.fromMap(
              map['defaultShippingAddress'] as Map<String, dynamic>)
          : null,
      // shippingAddresses: List<ShippingAddress>.from(
      //   (map['shippingAddresses']).map<ShippingAddress>(
      //     (x) => ShippingAddress.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
      // paymentCards: [],
      // List<PaymentCard>.from(
      //   (map['paymentCards'] as List<int>).map<PaymentCard>(
      //     (x) => PaymentCard.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
      // cart: [],
      // List<CartItem>.from(
      //   (map['cart'] as List<int>).map<CartItem>(
      //     (x) => CartItem.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
      // promotions: []
      // List<Promotion>.from(
      //   (map['promotions'] as List<int>).map<Promotion>(
      //     (x) => Promotion.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);
}

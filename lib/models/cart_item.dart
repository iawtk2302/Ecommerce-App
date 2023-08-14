// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_app/extensions/string_extensions.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;
  final String size;
  final Color color;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.size,
    required this.color,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
      size: map['size'] as String,
      color: (map['color'] as String).toColor(),
    );
  }

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    String? size,
    Color? color,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }
}

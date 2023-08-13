// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_app/extensions/color_extensions.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class ProductDetail {
  final String id;
  final String productId;
  final String size;
  final Color color;
  final int quantity;
  ProductDetail({
    required this.id,
    required this.productId,
    required this.size,
    required this.color,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'size': size,
      'color': color.toColorCode(),
      'quantity': quantity,
    };
  }

  factory ProductDetail.fromMap(Map<String, dynamic> map) {
    return ProductDetail(
      id: map['id'] as String,
      productId: map['productId'] as String,
      size: map['size'] as String,
      color: (map['color'] as String).toColor(),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetail.fromJson(String source) =>
      ProductDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}

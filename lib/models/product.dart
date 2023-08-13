// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce_app/models/product_detail.dart';

class Product {
  final String id;
  final String categoryId;
  final String name;
  final String description;
  final double price;
  final ProductDetail detail;
  final Timestamp createdAt;
  final int reviewCount;
  final double averageRating;
  Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.detail,
    required this.createdAt,
    required this.reviewCount,
    required this.averageRating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'detail': detail.toMap(),
      'createdAt': createdAt,
      'reviewCount': reviewCount,
      'averageRating': averageRating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      categoryId: map['categoryId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      detail: ProductDetail.fromMap(map['detail'] as Map<String, dynamic>),
      createdAt: map['createdAt'] as Timestamp,
      reviewCount: map['reviewCount'] as int,
      averageRating: map['averageRating'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}

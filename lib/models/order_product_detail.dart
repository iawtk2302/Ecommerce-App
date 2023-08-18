import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderProductDetail {
  final String id;
  final String productId;
  final String productName;
  final double productPrice;
  final String productImgUrl;
  final String productBrand;
  final String color;
  final String size;
  final int quantity;

  OrderProductDetail({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImgUrl,
    required this.productBrand,
    required this.color,
    required this.size,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'productImgUrl': productImgUrl,
      'productBrand': productBrand,
      'color': color,
      'size': size,
      'quantity': quantity,
    };
  }

  factory OrderProductDetail.fromMap(Map<String, dynamic> map) {
    return OrderProductDetail(
      id: map['id'] as String,
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as double,
      productImgUrl: map['productImgUrl'] as String,
      productBrand: map['productBrand'] ?? "",
      color: map['color'] as String,
      size: map['size'] as String,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProductDetail.fromJson(String source) =>
      OrderProductDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}

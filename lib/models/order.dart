// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/extensions/order_status_extensions.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';

import 'package:ecommerce_app/models/order_product_detail.dart';
import 'package:ecommerce_app/models/order_status.dart';
import 'package:ecommerce_app/models/order_summary.dart';
import 'package:ecommerce_app/models/shipping_address.dart';

class OrderModel {
  final String id;
  final String orderNumber;
  final String customerId;
  final String customerName;
  final ShippingAddress address;
  final OrderSummary orderSummary;
  final bool isCompleted;
  final String paymentMethod;
  final bool isPayed;
  final OrderStatus currentOrderStatus;
  final Timestamp createdAt;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.customerId,
    required this.customerName,
    required this.address,
    required this.orderSummary,
    required this.isCompleted,
    required this.paymentMethod,
    required this.isPayed,
    required this.currentOrderStatus,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderNumber': orderNumber,
      'customerId': customerId,
      'customerName': customerName,
      'address': address.toMap(),
      'orderSummary': orderSummary.toMap(),
      'isCompleted': isCompleted,
      'paymentMethod': paymentMethod,
      'isPayed': isPayed,
      'currentOrderStatus': currentOrderStatus.toOrderStatusString(),
      'createdAt': createdAt,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      orderNumber: map['orderNumber'] as String,
      customerId: map['customerId'] as String,
      customerName: map['customerName'] as String,
      address: ShippingAddress.fromMap(map['address'] as Map<String, dynamic>),
      orderSummary:
          OrderSummary.fromMap(map['orderSummary'] as Map<String, dynamic>),
      isCompleted: map['isCompleted'] as bool,
      paymentMethod: map['paymentMethod'] as String,
      isPayed: map['isPayed'] as bool,
      currentOrderStatus: (map['currentOrderStatus'] as String).toOrderStatus(),
      createdAt: map['createdAt'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  OrderModel copyWith({
    String? id,
    String? orderNumber,
    String? customerId,
    String? customerName,
    ShippingAddress? address,
    List<OrderProductDetail>? items,
    OrderSummary? orderSummary,
    bool? isCompleted,
    String? paymentMethod,
    bool? isPayed,
    OrderStatus? currentOrderStatus,
    Timestamp? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      address: address ?? this.address,
      orderSummary: orderSummary ?? this.orderSummary,
      isCompleted: isCompleted ?? this.isCompleted,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isPayed: isPayed ?? this.isPayed,
      currentOrderStatus: currentOrderStatus ?? this.currentOrderStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }

//   "Not Shipped": The order has not been shipped yet.
// "In Transit": The order is currently in transit and on its way to the customer.
// "Out for Delivery": The order is out for delivery and will be delivered to the customer soon.
// "Delivered": The order has been successfully delivered to the customer.
// "Failed Delivery": The delivery attempt was unsuccessful, and the order needs to be rescheduled or reattempted.
// "Returned": The order was returned to the seller or the fulfillment center.
}

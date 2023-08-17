// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_app/extensions/promotion_type_extensions.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';

class Promotion {
  final String id;
  final String code;
  final String content;
  final String imgUrl;
  final PromotionType type;
  final double? minimumOrderValue;
  final double? maximumDiscountValue;
  final DateTime startTime;
  final DateTime endTime;

  Promotion({
    required this.id,
    required this.code,
    required this.content,
    required this.imgUrl,
    required this.type,
    this.minimumOrderValue,
    this.maximumDiscountValue,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'content': content,
      'imgUrl': imgUrl,
      'type': type.toPromotionString(),
      'minimumOrderValue': minimumOrderValue,
      'maximumDiscountValue': maximumDiscountValue,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory Promotion.fromMap(Map<String, dynamic> map) {
    switch ((map['type'] as String).toPromotion()) {
      case PromotionType.freeShipping:
        return FreeShippingPromotion.fromMap(map);
      case PromotionType.percentage:
        return PercentagePromotion.fromMap(map);
      case PromotionType.fixedAmount:
        return FixedAmountPromotion.fromMap(map);
      default:
        return FreeShippingPromotion.fromMap(map);
    }
  }

  String toJson() => json.encode(toMap());

  factory Promotion.fromJson(String source) =>
      Promotion.fromMap(json.decode(source) as Map<String, dynamic>);

  Promotion copyWith({
    String? id,
    String? code,
    String? content,
    String? imgUrl,
    PromotionType? type,
    double? minimumOrderValue,
    double? maximumDiscountValue,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return Promotion(
      id: id ?? this.id,
      code: code ?? this.code,
      content: content ?? this.content,
      imgUrl: imgUrl ?? this.imgUrl,
      type: type ?? this.type,
      minimumOrderValue: minimumOrderValue ?? this.minimumOrderValue,
      maximumDiscountValue: maximumDiscountValue ?? this.maximumDiscountValue,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}

class FreeShippingPromotion extends Promotion {
  FreeShippingPromotion(
      {required super.id,
      required super.code,
      required super.content,
      required super.imgUrl,
      required super.type,
      super.minimumOrderValue,
      super.maximumDiscountValue,
      required super.startTime,
      required super.endTime});

  factory FreeShippingPromotion.fromMap(Map<String, dynamic> map) {
    return FreeShippingPromotion(
      id: map['id'] as String,
      code: map['code'] as String,
      content: map['content'] as String,
      imgUrl: map['imgUrl'] as String,
      type: (map['type'] as String).toPromotion(),
      minimumOrderValue: map['minimumOrderValue']?.toDouble(),
      maximumDiscountValue: map['maximumDiscountValue']?.toDouble(),
      startTime: map['startTime'].toDate(),
      endTime: map['endTime'].toDate(),
    );
  }

  factory FreeShippingPromotion.fromJson(String source) =>
      FreeShippingPromotion.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class PercentagePromotion extends Promotion {
  final int percentage;

  PercentagePromotion(
      {required super.id,
      required super.code,
      required super.content,
      required super.imgUrl,
      required super.type,
      super.minimumOrderValue,
      super.maximumDiscountValue,
      required super.startTime,
      required super.endTime,
      required this.percentage});

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'content': content,
      'imgUrl': imgUrl,
      'type': type.toPromotionString(),
      'minimumOrderValue': minimumOrderValue,
      'maximumDiscountValue': maximumDiscountValue,
      'startTime': startTime,
      'endTime': endTime,
      'percentage': percentage,
    };
  }

  factory PercentagePromotion.fromMap(Map<String, dynamic> map) {
    return PercentagePromotion(
      id: map['id'] as String,
      code: map['code'] as String,
      content: map['content'] as String,
      imgUrl: map['imgUrl'] as String,
      type: (map['type'] as String).toPromotion(),
      minimumOrderValue: map['minimumOrderValue']?.toDouble(),
      maximumDiscountValue: map['maximumDiscountValue']?.toDouble(),
      startTime: map['startTime'].toDate(),
      endTime: map['endTime'].toDate(),
      percentage: map['percentage'] as int,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory PercentagePromotion.fromJson(String source) =>
      PercentagePromotion.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FixedAmountPromotion extends Promotion {
  final double amount;

  FixedAmountPromotion(
      {required super.id,
      required super.code,
      required super.content,
      required super.imgUrl,
      required super.type,
      super.maximumDiscountValue,
      super.minimumOrderValue,
      required super.startTime,
      required super.endTime,
      required this.amount});

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'content': content,
      'imgUrl': imgUrl,
      'type': type.toPromotionString(),
      'minimumOrderValue': minimumOrderValue,
      'maximumDiscountValue': maximumDiscountValue,
      'startTime': startTime,
      'endTime': endTime,
      'amount': amount,
    };
  }

  factory FixedAmountPromotion.fromMap(Map<String, dynamic> map) {
    return FixedAmountPromotion(
      id: map['id'] as String,
      code: map['code'] as String,
      content: map['content'] as String,
      imgUrl: map['imgUrl'] as String,
      type: (map['type'] as String).toPromotion(),
      minimumOrderValue: map['minimumOrderValue']?.toDouble(),
      maximumDiscountValue: map['maximumDiscountValue']?.toDouble(),
      startTime: map['startTime'].toDate(),
      endTime: map['endTime'].toDate(),
      amount: map['amount'].toDouble(),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory FixedAmountPromotion.fromJson(String source) =>
      FixedAmountPromotion.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum PromotionType { freeShipping, percentage, fixedAmount }

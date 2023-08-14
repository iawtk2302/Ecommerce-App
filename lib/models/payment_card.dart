import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentCard {
  final String id;
  final String holderName;
  final String cardNumber;
  final String expiryDate;
  final String cvvCode;
  final String cardType;
  PaymentCard({
    required this.id,
    required this.holderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvvCode,
    required this.cardType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'holderName': holderName,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvvCode': cvvCode,
      'cardType': cardType,
    };
  }

  factory PaymentCard.fromMap(Map<String, dynamic> map) {
    return PaymentCard(
      id: map['id'] as String,
      holderName: map['holderName'] as String,
      cardNumber: map['cardNumber'] as String,
      expiryDate: map['expiryDate'] as String,
      cvvCode: map['cvvCode'] as String,
      cardType: map['cardType'] ?? "otherBrand",
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentCard.fromJson(String source) =>
      PaymentCard.fromMap(json.decode(source) as Map<String, dynamic>);
}

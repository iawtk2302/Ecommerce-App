import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ShippingAddress {
  final String recipientName;
  final String street;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final String countryCallingCode;
  final String phoneNumber;
  final double? latitude;
  final double? longitude;

  ShippingAddress({
    required this.recipientName,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.countryCallingCode,
    required this.phoneNumber,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recipientName': recipientName,
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'countryCallingCode': countryCallingCode,
      'phoneNumber': phoneNumber,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory ShippingAddress.fromMap(Map<String, dynamic> map) {
    return ShippingAddress(
      recipientName: map['recipientName'] as String,
      street: map['street'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      zipCode: map['zipCode'] as String,
      countryCallingCode: map['countryCallingCode'] as String,
      phoneNumber: map['phoneNumber'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShippingAddress.fromJson(String source) =>
      ShippingAddress.fromMap(json.decode(source) as Map<String, dynamic>);
}

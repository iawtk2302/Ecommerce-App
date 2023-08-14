// ignore_for_file: public_member_api_docs, sort_constructors_first

class PaymentMethod {
  final String id;
  final String name;
  final String imageAsset;
  final String code;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.imageAsset,
    required this.code,
  });
}

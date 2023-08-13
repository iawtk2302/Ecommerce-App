// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'place_order_bloc.dart';

class PlaceOrderState extends Equatable {
  final ShippingAddress? address;
  final Promotion? promotion;

  const PlaceOrderState({
    this.address,
    this.promotion,
  });

  @override
  List<Object?> get props => [address, promotion];

  PlaceOrderState copyWith({
    ShippingAddress? address,
    Promotion? promotion,
  }) {
    return PlaceOrderState(
      address: address ?? this.address,
      promotion: promotion ?? this.promotion,
    );
  }
}

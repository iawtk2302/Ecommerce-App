// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'place_order_bloc.dart';

sealed class PlaceOrderEvent extends Equatable {
  const PlaceOrderEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAddress extends PlaceOrderEvent {
  final ShippingAddress? address;

  const UpdateAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class UpdatePromotion extends PlaceOrderEvent {
  final Promotion promotion;
  const UpdatePromotion(this.promotion);

  @override
  List<Object?> get props => [promotion];
}

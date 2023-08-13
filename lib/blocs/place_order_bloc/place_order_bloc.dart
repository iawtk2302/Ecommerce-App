import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/promotion.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:equatable/equatable.dart';

part 'place_order_event.dart';
part 'place_order_state.dart';

class PlaceOrderBloc extends Bloc<PlaceOrderEvent, PlaceOrderState> {
  PlaceOrderBloc() : super(const PlaceOrderState()) {
    on<UpdateAddress>(_onUpdateAddress);
    on<UpdatePromotion>(_onUpdatePromotion);
  }

  void _onUpdateAddress(UpdateAddress event, Emitter<PlaceOrderState> emit) {
    emit(state.copyWith(address: event.address));
  }

  void _onUpdatePromotion(event, emit) {
    emit(state.copyWith(promotion: event.promotion));
  }
}

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/repositories/order_repository.dart';
import 'package:equatable/equatable.dart';

part 'order_processing_event.dart';
part 'order_processing_state.dart';

class OrderProcessingBloc
    extends Bloc<OrderProcessingEvent, OrderProcessingState> {
  OrderProcessingBloc() : super(OrderProcessingInitial()) {
    on<AddOrder>(_onAddOrder);
    on<ResetOrderProcessingState>(_onResetOrderProcessingState);
  }

  void _onAddOrder(AddOrder event, Emitter<OrderProcessingState> emit) async {
    emit(OrderProcessingAdding());
    try {
      final String orderId = await OrderRepository()
          .addOrder(order: event.order, items: event.items);
      final order = event.order.copyWith(id: orderId);
      emit(OrderProcessingSuccessfully(order: order));
    } catch (e) {
      emit(OrderProcessingFailed(message: e.toString()));
    }
  }

  _onResetOrderProcessingState(event, emit) {
    emit(OrderProcessingInitial());
  }
}

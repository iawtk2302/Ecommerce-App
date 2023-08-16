part of 'order_processing_bloc.dart';

sealed class OrderProcessingEvent extends Equatable {
  const OrderProcessingEvent();

  @override
  List<Object> get props => [];
}

class AddOrder extends OrderProcessingEvent {
  final OrderModel order;
  final List<CartItem> items;

  const AddOrder({
    required this.order,
    required this.items,
  });

  @override
  List<Object> get props => [order, items];
}

class ResetOrderProcessingState extends OrderProcessingEvent {}

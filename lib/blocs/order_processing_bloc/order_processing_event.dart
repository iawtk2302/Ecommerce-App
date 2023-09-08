part of 'order_processing_bloc.dart';

sealed class OrderProcessingEvent extends Equatable {
  const OrderProcessingEvent();

  @override
  List<Object> get props => [];
}

class AddOrder extends OrderProcessingEvent {
  final OrderModel order;
  final List<CartItem> items;
  final String cardNumber;
  final List<CartItem> cartItems;

  const AddOrder({
    required this.order,
    required this.items,
    required this.cardNumber,
    required this.cartItems,
  });

  @override
  List<Object> get props => [order, items, cardNumber, cartItems];
}

class ResetOrderProcessingState extends OrderProcessingEvent {}

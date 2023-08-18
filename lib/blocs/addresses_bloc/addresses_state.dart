part of 'addresses_bloc.dart';

sealed class AddressesState extends Equatable {
  const AddressesState();

  @override
  List<Object> get props => [];
}

final class AddressesInitial extends AddressesState {}

class AddressesLoaded extends AddressesState {
  final List<ShippingAddress> addresses;

  const AddressesLoaded(this.addresses);

  @override
  List<Object> get props => [addresses];
}

class AddressesLoading extends AddressesState {}

class AddressesError extends AddressesState {
  final String message;

  const AddressesError(this.message);

  @override
  List<Object> get props => [message];
}

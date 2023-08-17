part of 'addresses_bloc.dart';

sealed class AddressesEvent extends Equatable {
  const AddressesEvent();

  @override
  List<Object> get props => [];
}

class LoadAddresses extends AddressesEvent {}

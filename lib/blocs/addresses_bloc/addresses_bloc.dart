import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/repositories/address_repository.dart';
import 'package:equatable/equatable.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  AddressesBloc() : super(AddressesInitial()) {
    on<LoadAddresses>(_onLoadAddresses);
  }
  _onLoadAddresses(event, emit) async {
    emit(AddressesLoading());
    try {
      final addresses = await AddressRepository().fetchShippingAddresses();
      emit(AddressesLoaded(addresses));
    } catch (e) {
      emit(AddressesError(e.toString()));
    }
  }
}

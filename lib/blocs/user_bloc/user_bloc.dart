import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/constants/enums/gender.dart';
import 'package:ecommerce_app/models/user_profile.dart';
import 'package:ecommerce_app/repositories/user_repository.dart';
import 'package:ecommerce_app/services/call_service.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
    on<ReloadUser>(_onReloadUser);
    on<UpdateUser>(_onUpdateUser);
  }

  _onLoadUser(event, emit) async {
    try {
      final UserProfile user = await UserRepository().fetchUser();
      await CallService().initCallService(user);
      emit(UserLoaded(user: user));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  _onReloadUser(event, emit) async {
    try {
      final UserProfile user = await UserRepository().fetchUser();
      if (state is UserLoaded) {
        emit((state as UserLoaded).copyWith(user: user));
      }
    } catch (e) {
      print("Load user error: $e");
    }
  }

  _onUpdateUser(UpdateUser event, emit) async {
    if (state is UserLoaded) {
      await UserRepository().updateUser(
          name:
              event.name != (state as UserLoaded).user.name ? event.name : null,
          age: event.age != (state as UserLoaded).user.age ? event.age : null,
          gender: event.gender != (state as UserLoaded).user.gender
              ? genderToString[event.gender]
              : null,
          email: event.email != (state as UserLoaded).user.email
              ? event.email
              : null,
          image: event.image);

      // Reload user
      final UserProfile user = await UserRepository().fetchUser();
      if (state is UserLoaded) {
        emit(UserUpdated());
        emit(UserLoaded(user: user));
      }
    }
  }
}

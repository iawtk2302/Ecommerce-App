import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/user_profile.dart';
import 'package:ecommerce_app/repositories/user_repository.dart';
import 'package:ecommerce_app/services/call_service.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
    on<ReloadUser>(_onReloadUser);
  }

  _onLoadUser(event, emit) async {
    try {
      emit(UserLoading());
      final UserProfile user = await UserRepository().fetchUser();
      await CallService().initCallService(user);
      emit(UserLoaded(user: user));
    } catch (e) {
      emit(UserError(message: e.toString()));
      print("Load user error: $e");
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
}

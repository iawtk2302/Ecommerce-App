import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/user_profile.dart';
import 'package:ecommerce_app/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
  }

  _onLoadUser(event, emit) async {
    try {
      emit(UserLoading());
      final UserProfile user = await UserRepository().fetchUser();
      emit(UserLoaded(user: user));
    } catch (e) {
      emit(UserError(message: e.toString()));
      print("Load user error: $e");
    }
  }
}

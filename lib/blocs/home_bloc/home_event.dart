part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadHome extends HomeEvent {
  const LoadHome();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

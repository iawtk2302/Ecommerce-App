part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();
}

class LanguageInitial extends LanguageState {
  @override
  List<Object> get props => [];
}

class LanguageLoaded extends LanguageState {
  final String locate;

  const LanguageLoaded({required this.locate});
  @override
  List<Object> get props => [locate];
}

class LanguageLoading extends LanguageState {
  @override
  List<Object> get props => [];
}

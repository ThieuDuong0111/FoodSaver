part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomePageLoadingState extends HomeState {}

class HomePageErrorState extends HomeState {
  const HomePageErrorState({required this.failure});
  final Failure failure;
}

class HomePageFinishedState extends HomeState {
  const HomePageFinishedState({
    required this.homeEntity,
  });
  final HomeEntity homeEntity;
}

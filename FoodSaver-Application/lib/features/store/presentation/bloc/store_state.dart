part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}

class StoresPageLoadingState extends StoreState {}

class StoresPageErrorState extends StoreState {
  const StoresPageErrorState({required this.failure});
  final Failure failure;
}

class StoresPageFinishedState extends StoreState {
  const StoresPageFinishedState({
    required this.listStores,
  });
  final List<UserEntity> listStores;
}

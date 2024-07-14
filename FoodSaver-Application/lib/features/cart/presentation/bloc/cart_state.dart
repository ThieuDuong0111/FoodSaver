part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartPageLoadingState extends CartState {}

class CartPageErrorState extends CartState {
  const CartPageErrorState({required this.failure});
  final Failure failure;
}

class CartPageFinishedState extends CartState {
  const CartPageFinishedState({
    required this.cartEntity,
  });
  final CartEntity cartEntity;
}

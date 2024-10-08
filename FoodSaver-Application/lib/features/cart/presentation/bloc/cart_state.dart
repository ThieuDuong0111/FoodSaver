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

class CartCheckoutLoadingState extends CartState {}

class CartCheckoutErrorState extends CartState {
  const CartCheckoutErrorState({required this.failure});
  final Failure failure;
}

class CartCheckoutFinishedState extends CartState {
  const CartCheckoutFinishedState({
    required this.cartEntity,
  });
  final CartEntity cartEntity;
}

class CartCompleteLoadingState extends CartState {}

class CartCompleteErrorState extends CartState {
  const CartCompleteErrorState({required this.failure});
  final Failure failure;
}

class CartCompleteFinishedState extends CartState {
  const CartCompleteFinishedState({
    required this.listOrderEntity,
  });
  final List<OrderEntity> listOrderEntity;
}

part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartGetItemsEvent extends CartEvent {
  const CartGetItemsEvent();
}

class CartUpdateItemEvent extends CartEvent {
  const CartUpdateItemEvent({required this.cartUpdateRequest});

  final CartUpdateRequest cartUpdateRequest;
}

class CartDeleteItemEvent extends CartEvent {
  const CartDeleteItemEvent({required this.id});
  final int id;
}

class CartCheckoutEvent extends CartEvent {
  const CartCheckoutEvent();
}

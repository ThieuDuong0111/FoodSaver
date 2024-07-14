part of 'order_history_bloc.dart';

abstract class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object> get props => [];
}

class OrderHistoryInitial extends OrderHistoryState {}

class OrderHistoryPageLoadingState extends OrderHistoryState {}

class OrderHistoryPageErrorState extends OrderHistoryState {
  const OrderHistoryPageErrorState({required this.failure});
  final Failure failure;
}

class OrderHistoryPageFinishedState extends OrderHistoryState {
  const OrderHistoryPageFinishedState({
    required this.listOrderEntity,
  });
  final List<OrderEntity> listOrderEntity;
}

class OrderDetailPageLoadingState extends OrderHistoryState {}

class OrderDetailPageErrorState extends OrderHistoryState {
  const OrderDetailPageErrorState({required this.failure});
  final Failure failure;
}

class OrderDetailPageFinishedState extends OrderHistoryState {
  const OrderDetailPageFinishedState({
    required this.orderEntity,
  });
  final OrderEntity orderEntity;
}

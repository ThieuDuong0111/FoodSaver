part of 'order_history_bloc.dart';

abstract class OrderHistoryEvent extends Equatable {
  const OrderHistoryEvent();

  @override
  List<Object> get props => [];
}

class OrderHistoryPageEvent extends OrderHistoryEvent {
  const OrderHistoryPageEvent();
}

class OrderDetailPageEvent extends OrderHistoryEvent {
  const OrderDetailPageEvent({required this.orderId});
  final int orderId;
}

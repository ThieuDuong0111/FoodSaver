part of 'order_history_bloc.dart';

abstract class OrderHistoryState extends Equatable {
  const OrderHistoryState();  

  @override
  List<Object> get props => [];
}
class OrderHistoryInitial extends OrderHistoryState {}

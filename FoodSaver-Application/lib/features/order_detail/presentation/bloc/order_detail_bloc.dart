import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailBloc() : super(OrderDetailInitial()) {
    on<OrderDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

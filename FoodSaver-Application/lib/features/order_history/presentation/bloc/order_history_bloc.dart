import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/entities/order_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/usecases/order_detail_usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/usecases/order_history_usecase.dart';
import 'package:injectable/injectable.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

@injectable
class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc(this._orderHistoryUsecase, this._orderDetailUsecase) : super(OrderHistoryInitial()) {
    on<OrderHistoryPageEvent>(_orderHistoryPage);
    on<OrderDetailPageEvent>(_orderDetailPage);
  }

  final OrderHistoryUsecase _orderHistoryUsecase;

  FutureOr<void> _orderHistoryPage(
    OrderHistoryPageEvent event,
    Emitter<OrderHistoryState> emit,
  ) async {
    emit(OrderHistoryPageLoadingState());
    final Either<Failure, List<OrderEntity>> result = await _orderHistoryUsecase(NoParams());
    result.fold(
      (left) => emit(OrderHistoryPageErrorState(failure: left)),
      (right) => emit(OrderHistoryPageFinishedState(listOrderEntity: right)),
    );
  }

  final OrderDetailUsecase _orderDetailUsecase;

  FutureOr<void> _orderDetailPage(
    OrderDetailPageEvent event,
    Emitter<OrderHistoryState> emit,
  ) async {
    emit(OrderDetailPageLoadingState());
    final Either<Failure, OrderEntity> result = await _orderDetailUsecase(event.orderId);
    result.fold(
      (left) => emit(OrderDetailPageErrorState(failure: left)),
      (right) => emit(OrderDetailPageFinishedState(orderEntity: right)),
    );
  }
}

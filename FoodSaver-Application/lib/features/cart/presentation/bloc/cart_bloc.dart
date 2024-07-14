import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_update_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/usecases/cart_delete_item_usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/usecases/cart_get_items_usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/usecases/cart_update_item_usecase.dart';
import 'package:injectable/injectable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._cartGetItemsUsecase, this._cartUpdateItemUsecase, this._cartDeleteItemUsecase) : super(CartInitial()) {
    on<CartGetItemsEvent>(_getItems);
    on<CartUpdateItemEvent>(_updateItem);
    on<CartDeleteItemEvent>(_deleteItem);
  }

  final CartGetItemsUsecase _cartGetItemsUsecase;

  FutureOr<void> _getItems(
    CartGetItemsEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartPageLoadingState());
    final Either<Failure, CartEntity> result = await _cartGetItemsUsecase(NoParams());
    result.fold(
      (left) => emit(CartPageErrorState(failure: left)),
      (right) => emit(CartPageFinishedState(cartEntity: right)),
    );
  }

  final CartUpdateItemUsecase _cartUpdateItemUsecase;

  FutureOr<void> _updateItem(
    CartUpdateItemEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartPageLoadingState());
    final Either<Failure, CartEntity> result = await _cartUpdateItemUsecase(event.cartUpdateRequest);
    result.fold(
      (left) => emit(CartPageErrorState(failure: left)),
      (right) => emit(CartPageFinishedState(cartEntity: right)),
    );
  }

  final CartDeleteItemUsecase _cartDeleteItemUsecase;

  FutureOr<void> _deleteItem(
    CartDeleteItemEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartPageLoadingState());
    final Either<Failure, CartEntity> result = await _cartDeleteItemUsecase(event.id);
    result.fold(
      (left) => emit(CartPageErrorState(failure: left)),
      (right) => emit(CartPageFinishedState(cartEntity: right)),
    );
  }
}

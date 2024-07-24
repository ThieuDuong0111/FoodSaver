import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/data/datasources/cart_checkout_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/data/datasources/cart_complete_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/data/datasources/cart_delete_item_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/data/datasources/cart_get_items_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/data/datasources/cart_update_item_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_complete_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_update_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/repositories/cart_repository.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/entities/order_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl extends CartRepository {
  CartRepositoryImpl(
    this._cartGetItemsRemoteDataSource,
    this._cartUpdateItemRemoteDataSource,
    this._cartDeleteItemRemoteDataSource,
    this._cartCheckoutRemoteDataSource,
    this._cartCompleteRemoteDataSource,
  );
  final CartGetItemsRemoteDataSource _cartGetItemsRemoteDataSource;
  final CartUpdateItemRemoteDataSource _cartUpdateItemRemoteDataSource;
  final CartDeleteItemRemoteDataSource _cartDeleteItemRemoteDataSource;
  final CartCheckoutRemoteDataSource _cartCheckoutRemoteDataSource;
  final CartCompleteRemoteDataSource _cartCompleteRemoteDataSource;

  @override
  Future<Either<Failure, CartEntity>> deleteItem(int id) {
    return _cartDeleteItemRemoteDataSource.cartDeleteItem(id);
  }

  @override
  Future<Either<Failure, CartEntity>> getItems() {
    return _cartGetItemsRemoteDataSource.cartGetItems();
  }

  @override
  Future<Either<Failure, CartEntity>> updateItem(CartUpdateRequest cartUpdateRequest) {
    return _cartUpdateItemRemoteDataSource.cartUpdateItem(cartUpdateRequest);
  }

  @override
  Future<Either<Failure, CartEntity>> checkout() {
    return _cartCheckoutRemoteDataSource.cartCheckOut();
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> completeOrder(CartCompleteRequest cartCompleteRequest) {
    return _cartCompleteRemoteDataSource.cartComplete(cartCompleteRequest);
  }
}

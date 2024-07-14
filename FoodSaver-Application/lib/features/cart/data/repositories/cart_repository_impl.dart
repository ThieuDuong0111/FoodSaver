import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/data/datasources/cart_delete_item_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/data/datasources/cart_get_items_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/data/datasources/cart_update_item_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_update_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl extends CartRepository {
  CartRepositoryImpl(
    this._cartGetItemsRemoteDataSource,
    this._cartUpdateItemRemoteDataSource,
    this._cartDeleteItemRemoteDataSource,
  );
  final CartGetItemsRemoteDataSource _cartGetItemsRemoteDataSource;
  final CartUpdateItemRemoteDataSource _cartUpdateItemRemoteDataSource;
  final CartDeleteItemRemoteDataSource _cartDeleteItemRemoteDataSource;

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
}

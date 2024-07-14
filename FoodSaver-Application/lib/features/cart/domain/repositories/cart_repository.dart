import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_update_request.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> getItems();
  Future<Either<Failure, CartEntity>> updateItem(CartUpdateRequest cartUpdateRequest);
  Future<Either<Failure, CartEntity>> deleteItem(int id);
  Future<Either<Failure, CartEntity>> checkout();
}

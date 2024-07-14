import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CartDeleteItemUsecase extends UseCaseHandleFailure<CartEntity, int> {
  CartDeleteItemUsecase(this._cartRepository);

  final CartRepository _cartRepository;

  @override
  Future<Either<Failure, CartEntity>> call(int params) {
    return _cartRepository.deleteItem(params);
  }
}

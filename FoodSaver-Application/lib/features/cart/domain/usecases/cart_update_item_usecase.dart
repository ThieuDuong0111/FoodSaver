import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_update_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CartUpdateItemUsecase extends UseCaseHandleFailure<CartEntity, CartUpdateRequest> {
  CartUpdateItemUsecase(this._cartRepository);

  final CartRepository _cartRepository;

  @override
  Future<Either<Failure, CartEntity>> call(CartUpdateRequest params) {
    return _cartRepository.updateItem(params);
  }
}

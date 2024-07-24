import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_complete_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/repositories/cart_repository.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/entities/order_entity.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CartCompleteUsecase extends UseCaseHandleFailure<List<OrderEntity>, CartCompleteRequest> {
  CartCompleteUsecase(this._cartRepository);

  final CartRepository _cartRepository;

  @override
  Future<Either<Failure, List<OrderEntity>>> call(CartCompleteRequest params) {
    return _cartRepository.completeOrder(params);
  }
}

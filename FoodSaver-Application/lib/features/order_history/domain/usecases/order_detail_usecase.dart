import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/entities/order_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OrderDetailUsecase extends UseCaseHandleFailure<OrderEntity, int> {
  OrderDetailUsecase(this._orderRepository);

  final OrderRepository _orderRepository;

  @override
  Future<Either<Failure, OrderEntity>> call(int params) {
    return _orderRepository.orderDetailPage(params);
  }
}

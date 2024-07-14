import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/entities/order_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OrderHistoryUsecase extends UseCaseHandleFailure<List<OrderEntity>, NoParams> {
  OrderHistoryUsecase(this._orderRepository);

  final OrderRepository _orderRepository;

  @override
  Future<Either<Failure, List<OrderEntity>>> call(NoParams params) {
    return _orderRepository.orderHistoryPage();
  }
}

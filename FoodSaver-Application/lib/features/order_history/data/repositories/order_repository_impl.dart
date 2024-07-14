import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/data/datasources/order_detail_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/data/datasources/order_history_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/entities/order_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/repositories/order_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl extends OrderRepository {
  OrderRepositoryImpl(this._orderHistoryRemoteDataSource, this._orderDetailRemoteDataSource);
  final OrderHistoryRemoteDataSource _orderHistoryRemoteDataSource;
  final OrderDetailRemoteDataSource _orderDetailRemoteDataSource;

  @override
  Future<Either<Failure, List<OrderEntity>>> orderHistoryPage() async {
    return _orderHistoryRemoteDataSource.getOrderHistory();
  }

  @override
  Future<Either<Failure, OrderEntity>> orderDetailPage(int orderId) {
    return _orderDetailRemoteDataSource.getOrderDetail(orderId);
  }
}

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/http_client/app_http_client.dart';
import 'package:funix_thieudvfx_foodsaver/core/storage/app_storage.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/data/models/order_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/entities/order_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/mapper/order_from_model_to_order_entity_mapper.dart';
import 'package:http/http.dart';

abstract class OrderDetailRemoteDataSource {
  Future<Either<Failure, OrderEntity>> getOrderDetail(int orderId);
}

@LazySingleton(as: OrderDetailRemoteDataSource)
class OrderDetailRemoteDataSourceImpl implements OrderDetailRemoteDataSource {
  OrderDetailRemoteDataSourceImpl(
    this._appHttpClient,
    this._orderFromModelToEntityMapper,
    this._appStorage,
  );
  final AppStorage _appStorage;
  final AppHttpClient _appHttpClient;
  final OrderFromModelToEntityMapper _orderFromModelToEntityMapper;

  @override
  Future<Either<Failure, OrderEntity>> getOrderDetail(int orderId) async {
    try {
      final String? token = await _appStorage.readValue(key: 'token');
      if (token == null) {
        throw Exception();
      }
      final Response response = await _appHttpClient.get(
        Uri.parse(
          '${ApiEndpoints.baseUrl}/order/order-detail/$orderId',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final OrderModel model = OrderModel.fromJson(json.decode(_appHttpClient.utf8convert(response.body)));
      if (response.statusCode == 200) {
        return Right(_orderFromModelToEntityMapper.fromModel(model));
      }
      throw Exception();
    } catch (error) {
      return Left(APIException.handle(error).failure);
    }
  }
}

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/http_client/app_http_client.dart';
import 'package:funix_thieudvfx_foodsaver/core/storage/app_storage.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/data/models/cart_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/mapper/cart_from_model_to_cart_entity_mapper.dart';
import 'package:http/http.dart';

abstract class CartGetItemsRemoteDataSource {
  Future<Either<Failure, CartEntity>> cartGetItems();
}

@LazySingleton(as: CartGetItemsRemoteDataSource)
class CartGetItemsRemoteDataSourceImpl implements CartGetItemsRemoteDataSource {
  CartGetItemsRemoteDataSourceImpl(
    this._appStorage,
    this._appHttpClient,
    this._cartFromModelToEntityMapper,
  );

  final AppStorage _appStorage;
  final AppHttpClient _appHttpClient;
  final CartFromModelToEntityMapper _cartFromModelToEntityMapper;

  @override
  Future<Either<Failure, CartEntity>> cartGetItems() async {
    try {
      final String? token = await _appStorage.readValue(key: 'token');
      if (token == null) {
        throw Exception();
      }
      final Response response = await _appHttpClient.get(
        Uri.parse(
          '${ApiEndpoints.baseUrl}/cart/get-items',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final CartModel model = CartModel.fromJson(json.decode(_appHttpClient.utf8convert(response.body)));
      if (response.statusCode == 200) {
        return Right(_cartFromModelToEntityMapper.fromModel(model));
      }
      throw Exception();
    } catch (error) {
      return Left(APIException.handle(error).failure);
    }
  }
}

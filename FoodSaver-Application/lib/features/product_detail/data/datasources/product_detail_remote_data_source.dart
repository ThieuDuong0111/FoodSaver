import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/http_client/app_http_client.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/models/product_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/mapper/product_from_model_to_product_entity_mapper.dart';
import 'package:http/http.dart';

abstract class ProductDetailRemoteDataSource {
  Future<Either<Failure, ProductEntity>> getProductDetail(int productId);
}

@LazySingleton(as: ProductDetailRemoteDataSource)
class ProductDetailRemoteDataSourceImpl implements ProductDetailRemoteDataSource {
  ProductDetailRemoteDataSourceImpl(
    this._appHttpClient,
    this._productFromModelToEntityMapper,
  );

  final AppHttpClient _appHttpClient;
  final ProductFromModelToEntityMapper _productFromModelToEntityMapper;

  @override
  Future<Either<Failure, ProductEntity>> getProductDetail(int productId) async {
    try {
      final Response response = await _appHttpClient.get(
        Uri.parse(
          '${ApiEndpoints.baseUrl}/product/$productId',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final ProductModel model = ProductModel.fromJson(json.decode(response.body));
        return Right(_productFromModelToEntityMapper.fromModel(model));
      }
      throw Exception();
    } catch (error) {
      return Left(APIException.handle(error).failure);
    }
  }
}

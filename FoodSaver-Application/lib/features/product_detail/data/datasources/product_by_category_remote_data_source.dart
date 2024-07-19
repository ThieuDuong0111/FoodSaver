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

abstract class ProductByCategoryRemoteDataSource {
  Future<Either<Failure, List<ProductEntity>>> getProductByCategory(int categoryId);
}

@LazySingleton(as: ProductByCategoryRemoteDataSource)
class ProductByCategoryRemoteDataSourceImpl implements ProductByCategoryRemoteDataSource {
  ProductByCategoryRemoteDataSourceImpl(
    this._appHttpClient,
    this._productFromModelToEntityMapper,
  );

  final AppHttpClient _appHttpClient;
  final ProductFromModelToEntityMapper _productFromModelToEntityMapper;

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductByCategory(int categoryId) async {
    try {
      final Response response = await _appHttpClient.get(
        Uri.parse(
          '${ApiEndpoints.baseUrl}/products/by-category/$categoryId',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body) as List<dynamic>;
        final List<ProductModel> models =
            jsonResponse.map((json) => ProductModel.fromJson(json as Map<String, dynamic>)).toList();
        final List<ProductEntity> entities = models.map(_productFromModelToEntityMapper.fromModel).toList();
        return Right(entities);
      }
      throw Exception();
    } catch (error) {
      return Left(APIException.handle(error).failure);
    }
  }
}

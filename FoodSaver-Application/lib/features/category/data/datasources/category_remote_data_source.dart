import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/http_client/app_http_client.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/data/models/category_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/domain/entities/category_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/domain/mapper/category_from_model_to_category_entity_mapper.dart';
import 'package:http/http.dart';

abstract class CategoryRemoteDataSource {
  Future<Either<Failure, List<CategoryEntity>>> getListCategories();
}

@LazySingleton(as: CategoryRemoteDataSource)
class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  CategoryRemoteDataSourceImpl(
    this._appHttpClient,
    this._categoryFromModelToEntityMapper,
  );

  final AppHttpClient _appHttpClient;
  final CategoryFromModelToEntityMapper _categoryFromModelToEntityMapper;

  @override
  Future<Either<Failure, List<CategoryEntity>>> getListCategories() async {
    try {
      final Response response = await _appHttpClient.get(
        Uri.parse(
          '${ApiEndpoints.baseUrl}/categories/all',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body) as List<dynamic>;
        final List<CategoryModel> models =
            jsonResponse.map((json) => CategoryModel.fromJson(json as Map<String, dynamic>)).toList();
        final List<CategoryEntity> entities =
            models.map((model) => _categoryFromModelToEntityMapper.fromModel(model)!).toList();
        return Right(entities);
      }
      throw Exception();
    } catch (error) {
      return Left(APIException.handle(error).failure);
    }
  }
}

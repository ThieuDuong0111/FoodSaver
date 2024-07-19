import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/http_client/app_http_client.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/models/feedback_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/feedback_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/mapper/feedback_from_model_to_feedback_entity_mapper.dart';
import 'package:http/http.dart';

abstract class ProductGetFeedBacksRemoteDataSource {
  Future<Either<Failure, List<FeedBackEntity>>> productGetFeedBacks(int productId);
}

@LazySingleton(as: ProductGetFeedBacksRemoteDataSource)
class ProductGetFeedBacksRemoteDataSourceImpl implements ProductGetFeedBacksRemoteDataSource {
  ProductGetFeedBacksRemoteDataSourceImpl(
    this._appHttpClient,
    this._feedBackFromModelToEntityMapper,
  );

  final AppHttpClient _appHttpClient;
  final FeedBackFromModelToEntityMapper _feedBackFromModelToEntityMapper;

  @override
  Future<Either<Failure, List<FeedBackEntity>>> productGetFeedBacks(int productId) async {
    try {
      final Response response = await _appHttpClient.get(
        Uri.parse(
          '${ApiEndpoints.baseUrl}/feedback/get-feedbacks/$productId',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(_appHttpClient.utf8convert(response.body)) as List<dynamic>;
        final List<FeedBackModel> models =
            jsonResponse.map((json) => FeedBackModel.fromJson(json as Map<String, dynamic>)).toList();
        final List<FeedBackEntity> entities = models.map(_feedBackFromModelToEntityMapper.fromModel).toList();
        return Right(entities);
      }
      throw Exception();
    } catch (error) {
      return Left(APIException.handle(error).failure);
    }
  }
}

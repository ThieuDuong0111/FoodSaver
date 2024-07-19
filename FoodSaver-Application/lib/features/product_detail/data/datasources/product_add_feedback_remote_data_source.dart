import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/http_client/app_http_client.dart';
import 'package:funix_thieudvfx_foodsaver/core/storage/app_storage.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/add_feedback_request.dart';
import 'package:http/http.dart';

abstract class ProductAddFeedBackRemoteDataSource {
  Future<Either<Failure, AddFeedBackRequest>> productAddFeedBack(AddFeedBackRequest addFeedBackRequest);
}

@LazySingleton(as: ProductAddFeedBackRemoteDataSource)
class ProductAddFeedBackRemoteDataSourceImpl implements ProductAddFeedBackRemoteDataSource {
  ProductAddFeedBackRemoteDataSourceImpl(
    this._appHttpClient,
    //   this._feedBackFromModelToEntityMapper,
    this._appStorage,
  );

  final AppStorage _appStorage;
  final AppHttpClient _appHttpClient;
//  final FeedBackFromModelToEntityMapper _feedBackFromModelToEntityMapper;

  @override
  Future<Either<Failure, AddFeedBackRequest>> productAddFeedBack(AddFeedBackRequest addFeedBackRequest) async {
    try {
      final String? token = await _appStorage.readValue(key: 'token');
      if (token == null) {
        throw Exception();
      }
      final Response response = await _appHttpClient.post(
        Uri.parse(
          '${ApiEndpoints.baseUrl}/feedback/add-feedback',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: addFeedBackRequest,
      );

      if (response.statusCode == 200) {
        final AddFeedBackRequest model =
            AddFeedBackRequest.fromJson(json.decode(_appHttpClient.utf8convert(response.body)));
        return Right(model);
      }
      throw Exception();
    } catch (error) {
      return Left(APIException.handle(error).failure);
    }
  }
}

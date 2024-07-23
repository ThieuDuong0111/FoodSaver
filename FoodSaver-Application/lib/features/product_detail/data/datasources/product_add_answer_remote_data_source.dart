import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/http_client/app_http_client.dart';
import 'package:funix_thieudvfx_foodsaver/core/storage/app_storage.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/add_answer_request.dart';
import 'package:http/http.dart';

abstract class ProductAddAnswerRemoteDataSource {
  Future<Either<Failure, AddAnswerRequest>> productAddAnswer(AddAnswerRequest addAnswerRequest);
}

@LazySingleton(as: ProductAddAnswerRemoteDataSource)
class ProductAddAnswerRemoteDataSourceImpl implements ProductAddAnswerRemoteDataSource {
  ProductAddAnswerRemoteDataSourceImpl(
    this._appHttpClient,
    //   this._feedBackFromModelToEntityMapper,
    this._appStorage,
  );

  final AppStorage _appStorage;
  final AppHttpClient _appHttpClient;
//  final AnswerFromModelToEntityMapper _feedBackFromModelToEntityMapper;

  @override
  Future<Either<Failure, AddAnswerRequest>> productAddAnswer(AddAnswerRequest addAnswerRequest) async {
    try {
      final String? token = await _appStorage.readValue(key: 'token');
      if (token == null) {
        throw Exception();
      }
      final Response response = await _appHttpClient.post(
        Uri.parse(
          '${ApiEndpoints.baseUrl}/feedback/add-answer',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: addAnswerRequest,
      );

      if (response.statusCode == 200) {
        final AddAnswerRequest model =
            AddAnswerRequest.fromJson(json.decode(_appHttpClient.utf8convert(response.body)));
        return Right(model);
      }
      throw Exception();
    } catch (error) {
      return Left(APIException.handle(error).failure);
    }
  }
}

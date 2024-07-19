import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/http_client/app_http_client.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/data/models/home_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/domain/entities/home_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/domain/mapper/home_from_model_to_home_entity_mapper.dart';
import 'package:http/http.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, HomeEntity>> getHome();
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(
    this._appHttpClient,
    this._homeFromModelToEntityMapper,
  );

  final AppHttpClient _appHttpClient;
  final HomeFromModelToEntityMapper _homeFromModelToEntityMapper;

  @override
  Future<Either<Failure, HomeEntity>> getHome() async {
    try {
      final Response response = await _appHttpClient.get(
        Uri.parse(
          '${ApiEndpoints.baseUrl}/home',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      final HomeModel model = HomeModel.fromJson(json.decode(_appHttpClient.utf8convert(response.body)));
      if (response.statusCode == 200) {
        return Right(_homeFromModelToEntityMapper.fromModel(model));
      }
      throw Exception();
    } catch (error) {
      return Left(APIException.handle(error).failure);
    }
  }
}

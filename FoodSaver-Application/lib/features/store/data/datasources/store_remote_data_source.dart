import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/http_client/app_http_client.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/data/models/user_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/mapper/user_from_model_to_user_entity_mapper.dart';
import 'package:http/http.dart';

abstract class StoreRemoteDataSource {
  Future<Either<Failure, List<UserEntity>>> getListStores();
}

@LazySingleton(as: StoreRemoteDataSource)
class StoreRemoteDataSourceImpl implements StoreRemoteDataSource {
  StoreRemoteDataSourceImpl(
    this._appHttpClient,
    this._userFromModelToEntityMapper,
  );

  final AppHttpClient _appHttpClient;
  final UserFromModelToEntityMapper _userFromModelToEntityMapper;

  @override
  Future<Either<Failure, List<UserEntity>>> getListStores() async {
    try {
      final Response response = await _appHttpClient.get(
        Uri.parse(
          '${ApiEndpoints.baseUrl}/store/all',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body) as List<dynamic>;
        final List<UserModel> models =
            jsonResponse.map((json) => UserModel.fromJson(json as Map<String, dynamic>)).toList();
        final List<UserEntity> entities =
            models.map((model) => _userFromModelToEntityMapper.fromModel(model)!).toList();
        return Right(entities);
      }
      throw Exception();
    } catch (error) {
      return Left(APIException.handle(error).failure);
    }
  }
}

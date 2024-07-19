import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/http_client/app_http_client.dart';
import 'package:funix_thieudvfx_foodsaver/core/storage/app_storage.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/data/models/user_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/mapper/user_from_model_to_user_entity_mapper.dart';
import 'package:http/http.dart';

abstract class UserInfoRemoteDataSource {
  Future<Either<Failure, UserEntity>> getUserInfo();
}

@LazySingleton(as: UserInfoRemoteDataSource)
class UserInfoRemoteDataSourceImpl implements UserInfoRemoteDataSource {
  UserInfoRemoteDataSourceImpl(
    this._appHttpClient,
    this._userFromModelToEntityMapper,
    this._appStorage,
  );
  final AppStorage _appStorage;
  final AppHttpClient _appHttpClient;
  final UserFromModelToEntityMapper _userFromModelToEntityMapper;

  @override
  Future<Either<Failure, UserEntity>> getUserInfo() async {
    try {
      final String? token = await _appStorage.readValue(key: 'token');
      if (token == null) {
        throw Exception();
      }
      final Response response = await _appHttpClient.get(
        Uri.parse(
          '${ApiEndpoints.baseUrl}/user/user-info',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final UserModel model = UserModel.fromJson(json.decode(_appHttpClient.utf8convert(response.body)));
      if (response.statusCode == 200) {
        return Right(_userFromModelToEntityMapper.fromModel(model)!);
      }
      throw Exception();
    } catch (error) {
      return Left(APIException.handle(error).failure);
    }
  }
}

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/http_client/app_http_client.dart';
import 'package:funix_thieudvfx_foodsaver/core/storage/app_storage.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/data/models/sign_in_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/mapper/sign_in_from_model_to_sign_in_entity_mapper.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

abstract class SignInRemoteDataSource {
  Future<Either<SignInEntity, SignInEntity>> signIn(SignInRequest signInRequest);
}

@LazySingleton(as: SignInRemoteDataSource)
class SignInRemoteDataSourceImpl implements SignInRemoteDataSource {
  SignInRemoteDataSourceImpl(
    this._appHttpClient,
    this._appStorage,
    this._signInFromModelToEntityMapper,
  );

  final AppHttpClient _appHttpClient;
  final AppStorage _appStorage;
  final SignInFromModelToEntityMapper _signInFromModelToEntityMapper;

  @override
  Future<Either<SignInEntity, SignInEntity>> signIn(SignInRequest signInRequest) async {
    SignInModel model =
        SignInModel(name: '', password: '', nameError: '', passwordError: '', hasError: false, token: '');
    try {
      final Response response = await _appHttpClient.post(
        Uri.parse(
          '${ApiEndpoints.baseUrl}/sign-in',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: signInRequest,
      );
      model = SignInModel.fromJson(json.decode(_appHttpClient.utf8convert(response.body)));
      if (response.statusCode == 200) {
        //Save token
        await _appStorage.writeValue(key: 'token', value: model.token);
        return Right(_signInFromModelToEntityMapper.fromModel(model)!);
      }
      throw Exception();
    } catch (error) {
      return Left(_signInFromModelToEntityMapper.fromModel(model)!);
    }
  }
}

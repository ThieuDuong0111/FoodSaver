import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/core/http_client/app_http_client.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/data/models/sign_up_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/entities/sign_up_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/mapper/sign_up_from_model_to_sign_up_entity_mapper.dart';
import 'package:http/http.dart';

abstract class SignUpRemoteDataSource {
  Future<Either<SignUpEntity, SignUpEntity>> signUp(SignUpRequest signUpRequest);
}

@LazySingleton(as: SignUpRemoteDataSource)
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  SignUpRemoteDataSourceImpl(
    this._appHttpClient,
    this._signUpFromModelToEntityMapper,
  );

  final AppHttpClient _appHttpClient;
  final SignUpFromModelToEntityMapper _signUpFromModelToEntityMapper;

  @override
  Future<Either<SignUpEntity, SignUpEntity>> signUp(SignUpRequest signUpRequest) async {
    SignUpModel model = SignUpModel(
      name: '',
      password: '',
      confirmPassword: '',
      email: '',
      phone: '',
      address: '',
      nameError: '',
      passwordError: '',
      confirmPasswordError: '',
      emailError: '',
      phoneError: '',
      addressError: '',
      hasError: false,
    );
    try {
      final Response response = await _appHttpClient.post(
        Uri.parse(
          '${ApiEndpoints.baseUrl}/sign-up',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: signUpRequest,
      );
      model = SignUpModel.fromJson(json.decode(_appHttpClient.utf8convert(response.body)));
      if (response.statusCode == 200) {
        return Right(_signUpFromModelToEntityMapper.fromModel(model)!);
      }
      throw Exception();
    } catch (error) {
      return Left(_signUpFromModelToEntityMapper.fromModel(model)!);
    }
  }
}

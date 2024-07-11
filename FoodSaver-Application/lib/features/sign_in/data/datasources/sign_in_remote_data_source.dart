import 'package:dio/dio.dart' hide Headers;
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/http_client/dio_provider.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/data/models/sign_in_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'sign_in_remote_data_source.g.dart';

abstract class SignInRemoteDataSource {
  Future<SignInModel> signIn(SignInRequest signInRequest);
}

@LazySingleton(as: SignInRemoteDataSource)
@RestApi()
abstract class SignInRemoteDataSourceImpl implements SignInRemoteDataSource {
  @factoryMethod
  factory SignInRemoteDataSourceImpl(DioProvider dio) =>
      _SignInRemoteDataSourceImpl(dio.create('Sign In API'), baseUrl: ApiEndpoints.baseUrl);

  @override
  @POST('/sign-in')
  @Headers(<String, String>{
    'Content-Type': 'application/json',
  })
  Future<SignInModel> signIn(@Body() SignInRequest signInRequest);
}

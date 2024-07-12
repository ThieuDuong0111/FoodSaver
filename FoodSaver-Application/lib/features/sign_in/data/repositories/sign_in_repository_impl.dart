import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/data/datasources/sign_in_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SignInRepository)
class SignInRepositoryImpl extends SignInRepository {
  SignInRepositoryImpl(
    this._signInRemoteDataSource,
  );
  final SignInRemoteDataSource _signInRemoteDataSource;

  @override
  Future<Either<SignInEntity, SignInEntity>> signIn(SignInRequest signInRequest) async {
    return _signInRemoteDataSource.signIn(signInRequest);
  }
}

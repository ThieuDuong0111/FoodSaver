import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/data/datasources/sign_up_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/entities/sign_up_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SignUpRepository)
class SignUpRepositoryImpl extends SignUpRepository {
  SignUpRepositoryImpl(this._signUpRemoteDataSource);
  final SignUpRemoteDataSource _signUpRemoteDataSource;

  @override
  Future<Either<SignUpEntity, SignUpEntity>> signUp(SignUpRequest signUpRequest) async {
    return _signUpRemoteDataSource.signUp(signUpRequest);
  }
}

import 'package:funix_thieudvfx_foodsaver/features/sign_in/data/datasources/sign_in_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/data/models/sign_in_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/mapper/sign_in_from_model_to_sign_in_entity_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SignInRepository)
class SignInRepositoryImpl extends SignInRepository {
  SignInRepositoryImpl(
    this._signInRemoteDataSource,
    this._signInFromModelToEntityMapper,
  );

  final SignInRemoteDataSource _signInRemoteDataSource;
  final SignInFromModelToEntityMapper _signInFromModelToEntityMapper;

  @override
  Future<SignInEntity> signIn(SignInRequest signInRequest) async {
    try {
      final SignInModel models = await _signInRemoteDataSource.signIn(
        signInRequest,
      );

      return _signInFromModelToEntityMapper.fromModel(models)!;
    } catch (error) {
      rethrow;
    }
  }
}

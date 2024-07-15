import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/data/datasources/edit_info_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/data/datasources/user_info_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/repositories/user_repository.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/usecases/edit_info_usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl(this._userInfoRemoteDataSource, this._editInfoRemoteDataSource);
  final UserInfoRemoteDataSource _userInfoRemoteDataSource;
  final EditInfoRemoteDataSource _editInfoRemoteDataSource;

  @override
  Future<Either<Failure, UserEntity>> userInfo() {
    return _userInfoRemoteDataSource.getUserInfo();
  }

  @override
  Future<Either<Failure, UserEntity>> editInfo(UserUpdatePrams userUpdatePrams) {
    return _editInfoRemoteDataSource.editInfo(userUpdatePrams);
  }
}

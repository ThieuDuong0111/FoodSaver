import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/data/datasources/user_info_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl(this._userInfoRemoteDataSource);
  final UserInfoRemoteDataSource _userInfoRemoteDataSource;

  @override
  Future<Either<Failure, UserEntity>> userInfo() {
    return _userInfoRemoteDataSource.getUserInfo();
  }
}

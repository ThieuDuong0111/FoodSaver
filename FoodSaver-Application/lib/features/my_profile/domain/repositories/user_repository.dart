import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/usecases/edit_info_usecase.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> userInfo();
  Future<Either<Failure, UserEntity>> editInfo(UserUpdatePrams userUpdatePrams);
}

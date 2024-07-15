import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_update_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EditInfoUsecase extends UseCaseHandleFailure<UserEntity, UserUpdatePrams> {
  EditInfoUsecase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Either<Failure, UserEntity>> call(UserUpdatePrams params) {
    return _userRepository.editInfo(params);
  }
}

class UserUpdatePrams {
  final File? avatar;
  final UserUpdateRequest userUpdateRequest;

  UserUpdatePrams({required this.avatar, required this.userUpdateRequest});
}

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EditInfoUsecase extends UseCaseHandleFailure<UserEntity, NoParams> {
  EditInfoUsecase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return _userRepository.userInfo();
  }
}

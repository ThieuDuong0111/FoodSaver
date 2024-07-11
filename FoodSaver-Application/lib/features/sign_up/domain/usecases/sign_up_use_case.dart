import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/entities/sign_up_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignUpUsecase extends UseCase<SignUpEntity, SignUpRequest> {
  SignUpUsecase(this._signUpRepository);

  final SignUpRepository _signUpRepository;

  @override
  Future<Either<SignUpEntity, SignUpEntity>> call(SignUpRequest params) {
    return _signUpRepository.signUp(params);
  }
}

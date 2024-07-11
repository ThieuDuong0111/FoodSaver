import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInUsecase extends UseCase<SignInEntity, SignInRequest> {
  SignInUsecase(this._signInRepository);

  final SignInRepository _signInRepository;

  @override
  Future<SignInEntity> call(SignInRequest param) {
    return _signInRepository.signIn(param);
  }
}

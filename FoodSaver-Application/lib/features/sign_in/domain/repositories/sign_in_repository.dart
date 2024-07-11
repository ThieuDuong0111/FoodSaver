import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_request.dart';

abstract class SignInRepository {
  Future<Either<SignInEntity, SignInEntity>> signIn(SignInRequest signInRequest);
}

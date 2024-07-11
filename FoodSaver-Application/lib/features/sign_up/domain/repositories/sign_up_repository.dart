import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/entities/sign_up_request.dart';

abstract class SignUpRepository {
  Future<Either<SignUpEntity, SignUpEntity>> signUp(SignUpRequest signUpRequest);
}

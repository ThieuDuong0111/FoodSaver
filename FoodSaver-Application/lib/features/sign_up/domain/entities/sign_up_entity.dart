import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';

part 'sign_up_entity.freezed.dart';

@freezed
class SignUpEntity with _$SignUpEntity implements DomainEntity {
  factory SignUpEntity({
    required String name,
    required String password,
    required String confirmPassword,
    required String email,
    required String phone,
    required String address,
    required String nameError,
    required bool passwordError,
    required bool confirmPasswordError,
    required bool emailError,
    required bool phoneError,
    required bool addressError,
    required bool hasError,
  }) = _SignUpEntity;

  SignUpEntity._();
}

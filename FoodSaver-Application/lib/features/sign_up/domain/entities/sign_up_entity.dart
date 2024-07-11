import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';

part 'sign_up_entity.freezed.dart';

@freezed
class SignUpEntity with _$SignUpEntity implements DomainEntity {
  factory SignUpEntity({
    required String? name,
    required String? password,
    required String? confirmPassword,
    required String? email,
    required String? phone,
    required String? address,
    required String? nameError,
    required String? passwordError,
    required String? confirmPasswordError,
    required String? emailError,
    required String? phoneError,
    required String? addressError,
    required bool hasError,
  }) = _SignUpEntity;

  SignUpEntity._();
}

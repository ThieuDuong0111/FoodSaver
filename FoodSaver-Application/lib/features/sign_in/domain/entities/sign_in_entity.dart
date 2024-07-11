import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';

part 'sign_in_entity.freezed.dart';

@freezed
class SignInEntity with _$SignInEntity implements DomainEntity {
  factory SignInEntity({
    required String name,
    required String password,
    required String nameError,
    required String passwordError,
    required bool hasError,
    required String token,
  }) = _SignInEntity;

  SignInEntity._();
}

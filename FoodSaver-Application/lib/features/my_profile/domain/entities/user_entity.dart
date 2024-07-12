import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity implements DomainEntity {
  factory UserEntity({
    required int id,
    required String? name,
    required String? imageUrl,
    required String? email,
    required String? phone,
    required String? address,
  }) = _UserEntity;

  UserEntity._();
}

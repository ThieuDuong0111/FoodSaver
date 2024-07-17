import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';

part 'banner_entity.freezed.dart';

@freezed
class BannerEntity with _$BannerEntity implements DomainEntity {
  factory BannerEntity({
    required int id,
    required String? name,
    required String? imageUrl,
  }) = _BannerEntity;
  BannerEntity._();
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';

part 'unit_entity.freezed.dart';

@freezed
class UnitEntity with _$UnitEntity implements DomainEntity {
  factory UnitEntity({
    required int id,
    required String name,
  }) = _UnitEntity;
  UnitEntity._();
}

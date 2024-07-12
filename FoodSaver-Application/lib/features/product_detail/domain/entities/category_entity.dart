import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';

part 'category_entity.freezed.dart';

@freezed
class CategoryEntity with _$CategoryEntity implements DomainEntity {
  factory CategoryEntity({
    required int id,
    required String? name,
    required String? description,
    required String? imageUrl,
  }) = _CategoryEntity;

  CategoryEntity._();
}

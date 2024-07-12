import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/domain/entities/category_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';

part 'home_entity.freezed.dart';

@freezed
class HomeEntity with _$HomeEntity implements DomainEntity {
  factory HomeEntity({
    required List<CategoryEntity?> categories,
    required List<ProductEntity?> products,
  }) = _HomeEntity;
  HomeEntity._();
}

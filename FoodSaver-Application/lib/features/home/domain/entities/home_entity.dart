import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/domain/entities/category_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/domain/entities/banner_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';

part 'home_entity.freezed.dart';

@freezed
class HomeEntity with _$HomeEntity implements DomainEntity {
  factory HomeEntity({
    required List<CategoryEntity?> categories,
    required List<UserEntity?> stores,
    required List<ProductEntity?> products,
    required List<BannerEntity?> banners,
  }) = _HomeEntity;
  HomeEntity._();
}

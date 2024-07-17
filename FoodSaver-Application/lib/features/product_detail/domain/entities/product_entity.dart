import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/domain/entities/category_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/unit_entity.dart';

part 'product_entity.freezed.dart';

@freezed
class ProductEntity with _$ProductEntity implements DomainEntity {
  factory ProductEntity({
    required int id,
    required CategoryEntity category,
    required UserEntity creator,
    required UnitEntity unit,
    required String? name,
    required String? description,
    required int price,
    required int discountPrice,
    required int quantity,
    required double? rating,
    required int commentsCount,
    required String? imageUrl,
    required DateTime? expiredDate,
    required bool? isExpired,
    required int ratingsCount,
    required int rating5Count,
    required int rating4Count,
    required int rating3Count,
    required int rating2Count,
    required int rating1Count,
  }) = _ProductEntity;
  ProductEntity._();
}

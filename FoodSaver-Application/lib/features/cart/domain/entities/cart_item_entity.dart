import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';

part 'cart_item_entity.freezed.dart';

@freezed
class CartItemEntity with _$CartItemEntity implements DomainEntity {
  factory CartItemEntity({
    required int id,
    required ProductEntity cartProduct,
    required int unitQuantity,
    required int unitPrice,
  }) = _CartItemEntity;
  CartItemEntity._();
}

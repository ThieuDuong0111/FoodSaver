import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_item_entity.dart';

part 'cart_by_creator_entity.freezed.dart';

@freezed
class CartByCreatorEntity with _$CartByCreatorEntity implements DomainEntity {
  factory CartByCreatorEntity({
    required List<CartItemEntity> cartItems,
  }) = _CartByCreatorEntity;
  CartByCreatorEntity._();
}

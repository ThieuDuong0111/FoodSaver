import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_item_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';

part 'cart_entity.freezed.dart';

@freezed
class CartEntity with _$CartEntity implements DomainEntity {
  factory CartEntity({
    required List<CartItemEntity?> cartItems,
    required UserEntity userCarts,
    required DateTime publishedDate,
    required bool isDone,
    required int totalAmount,
    required int itemsCount,
  }) = _CartEntity;
  CartEntity._();
}

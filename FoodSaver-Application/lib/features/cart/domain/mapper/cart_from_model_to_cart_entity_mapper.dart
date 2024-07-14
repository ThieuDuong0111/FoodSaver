import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/data/models/cart_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/mapper/cart_item_from_model_to_cart_item_entity_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/mapper/user_from_model_to_user_entity_mapper.dart';

abstract class CartFromModelToEntityMapper {
  CartEntity fromModel(CartModel model);
}

@LazySingleton(as: CartFromModelToEntityMapper)
class CartFromModelToEntityMapperImpl extends CartFromModelToEntityMapper {
  CartFromModelToEntityMapperImpl(
    this._cartItemFromModelToEntityMapper,
    this._userFromModelToEntityMapper,
  ) : super();

  final CartItemFromModelToEntityMapper _cartItemFromModelToEntityMapper;
  final UserFromModelToEntityMapper _userFromModelToEntityMapper;

  @override
  CartEntity fromModel(CartModel model) {
    final CartEntity cartEntity = CartEntity(
      cartItems: model.cartItems.map(_cartItemFromModelToEntityMapper.fromModel).toList(),
      userCarts: _userFromModelToEntityMapper.fromModel(model.userCarts)!,
      publishedDate: model.publishedDate,
      isDone: model.isDone,
      totalAmount: model.totalAmount,
      itemsCount: model.itemsCount,
    );
    return cartEntity;
  }
}

import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/data/models/cart_by_creator_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_by_creator_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/mapper/cart_item_from_model_to_cart_item_entity_mapper.dart';

abstract class CartByCreatorFromModelToEntityMapper {
  CartByCreatorEntity fromModel(CartByCreatorModel model);
}

@LazySingleton(as: CartByCreatorFromModelToEntityMapper)
class CartByCreatorFromModelToEntityMapperImpl extends CartByCreatorFromModelToEntityMapper {
  CartByCreatorFromModelToEntityMapperImpl(this._cartItemFromModelToEntityMapper) : super();

  final CartItemFromModelToEntityMapper _cartItemFromModelToEntityMapper;
  @override
  CartByCreatorEntity fromModel(CartByCreatorModel model) {
    final CartByCreatorEntity cartByCreatorEntity = CartByCreatorEntity(
      cartItems: model.cartItems.map(_cartItemFromModelToEntityMapper.fromModel).toList(),
    );
    return cartByCreatorEntity;
  }
}

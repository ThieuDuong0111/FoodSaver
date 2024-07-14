import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/data/models/cart_item_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_item_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/mapper/product_from_model_to_product_entity_mapper.dart';

abstract class CartItemFromModelToEntityMapper {
  CartItemEntity fromModel(CartItemModel model);
}

@LazySingleton(as: CartItemFromModelToEntityMapper)
class CartItemFromModelToEntityMapperImpl extends CartItemFromModelToEntityMapper {
  CartItemFromModelToEntityMapperImpl(
    this._productFromModelToEntityMapper,
  ) : super();

  final ProductFromModelToEntityMapper _productFromModelToEntityMapper;

  @override
  CartItemEntity fromModel(CartItemModel model) {
    final CartItemEntity cartIemEntity = CartItemEntity(
      id: model.id,
      cartProduct: _productFromModelToEntityMapper.fromModel(model.cartProduct),
      unitQuantity: model.unitQuantity,
      unitPrice: model.unitPrice,
    );
    return cartIemEntity;
  }
}

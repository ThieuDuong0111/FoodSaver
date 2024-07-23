import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/domain/mapper/category_from_model_to_category_entity_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/mapper/user_from_model_to_user_entity_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/models/product_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/unit_entity.dart';

abstract class ProductFromModelToEntityMapper {
  ProductEntity fromModel(ProductModel model);
}

@LazySingleton(as: ProductFromModelToEntityMapper)
class ProductFromModelToEntityMapperImpl extends ProductFromModelToEntityMapper {
  ProductFromModelToEntityMapperImpl(
    this._categoryFromModelToEntityMapper,
    this._userFromModelToEntityMapper,
  ) : super();

  final CategoryFromModelToEntityMapper _categoryFromModelToEntityMapper;
  final UserFromModelToEntityMapper _userFromModelToEntityMapper;

  @override
  ProductEntity fromModel(ProductModel model) {
    final ProductEntity productentity = ProductEntity(
      id: model.id,
      creator: _userFromModelToEntityMapper.fromModel(model.creator)!,
      category: _categoryFromModelToEntityMapper.fromModel(model.category)!,
      name: model.name,
      description: model.description,
      price: model.price,
      discountPrice: model.discountPrice,
      quantity: model.quantity,
      imageUrl: model.imageUrl,
      rating: model.rating,
      commentsCount: model.commentsCount,
      unit: UnitEntity(id: model.unit.id, name: model.unit.name),
      expiredDate: model.expiredDate,
      isExpired: model.isExpired,
      ratingsCount: model.ratingsCount,
      rating1Count: model.rating1Count,
      rating2Count: model.rating2Count,
      rating3Count: model.rating3Count,
      rating4Count: model.rating4Count,
      rating5Count: model.rating5Count,
      soldCount: model.soldCount,
    );
    return productentity;
  }
}

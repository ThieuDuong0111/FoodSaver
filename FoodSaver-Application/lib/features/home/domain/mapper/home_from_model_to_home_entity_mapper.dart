import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/domain/mapper/category_from_model_to_category_entity_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/data/models/home_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/domain/entities/home_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/domain/mapper/banner_from_model_to_banner_entity_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/mapper/user_from_model_to_user_entity_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/mapper/product_from_model_to_product_entity_mapper.dart';

abstract class HomeFromModelToEntityMapper {
  HomeEntity fromModel(HomeModel model);
}

@LazySingleton(as: HomeFromModelToEntityMapper)
class HomeFromModelToEntityMapperImpl extends HomeFromModelToEntityMapper {
  HomeFromModelToEntityMapperImpl(
    this._categoryFromModelToEntityMapper,
    this._productFromModelToEntityMapper,
    this._bannerFromModelToEntityMapper,
    this._userFromModelToEntityMapper,
  ) : super();

  final CategoryFromModelToEntityMapper _categoryFromModelToEntityMapper;
  final ProductFromModelToEntityMapper _productFromModelToEntityMapper;
  final BannerFromModelToEntityMapper _bannerFromModelToEntityMapper;
  final UserFromModelToEntityMapper _userFromModelToEntityMapper;

  @override
  HomeEntity fromModel(HomeModel model) {
    final HomeEntity homeEntity = HomeEntity(
      categories: model.categories.map(_categoryFromModelToEntityMapper.fromModel).toList(),
      products: model.products.map(_productFromModelToEntityMapper.fromModel).toList(),
      banners: model.banners.map(_bannerFromModelToEntityMapper.fromModel).toList(),
      stores: model.stores.map(_userFromModelToEntityMapper.fromModel).toList(),
    );
    return homeEntity;
  }
}

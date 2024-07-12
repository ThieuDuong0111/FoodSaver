import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/data/models/category_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/domain/entities/category_entity.dart';

part 'category_from_model_to_category_entity_mapper.mapper.g.dart';

@Mapper(useInjection: true)
abstract class CategoryFromModelToEntityMapper extends EntityFromModelMapper<CategoryEntity, CategoryModel> {}

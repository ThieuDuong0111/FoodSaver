import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/models/unit_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/unit_entity.dart';

part 'unit_from_model_to_unit_entity_mapper.mapper.g.dart';

@Mapper(useInjection: true)
abstract class UnitFromModelToEntityMapper extends EntityFromModelMapper<UnitEntity, UnitModel> {}

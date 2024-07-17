import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/data/models/banner_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/domain/entities/banner_entity.dart';

part 'banner_from_model_to_banner_entity_mapper.mapper.g.dart';

@Mapper(useInjection: true)
abstract class BannerFromModelToEntityMapper extends EntityFromModelMapper<BannerEntity, BannerModel> {}

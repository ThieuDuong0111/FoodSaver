import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/data/models/order_detail_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/entities/order_detail_entity.dart';

part 'order_detail_from_model_to_order_detail_entity_mapper.mapper.g.dart';

@Mapper(useInjection: true)
abstract class OrderDetailFromModelToEntityMapper extends EntityFromModelMapper<OrderDetailEntity, OrderDetailModel> {}

import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/data/models/sign_up_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/entities/sign_up_entity.dart';

part 'sign_up_from_model_to_sign_up_entity_mapper.mapper.g.dart';

@Mapper(useInjection: true)
abstract class SignUpFromModelToEntityMapper extends EntityFromModelMapper<SignUpEntity, SignUpModel> {}

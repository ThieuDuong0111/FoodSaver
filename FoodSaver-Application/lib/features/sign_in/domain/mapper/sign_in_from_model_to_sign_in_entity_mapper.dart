import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/data/models/sign_in_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_entity.dart';

part 'sign_in_from_model_to_sign_in_entity_mapper.mapper.g.dart';

@Mapper(useInjection: true)
abstract class SignInFromModelToEntityMapper extends EntityFromModelMapper<SignInEntity, SignInModel> {}

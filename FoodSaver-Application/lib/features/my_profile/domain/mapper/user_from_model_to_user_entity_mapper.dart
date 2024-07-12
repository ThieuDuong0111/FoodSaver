import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/data/models/user_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';

part 'user_from_model_to_user_entity_mapper.mapper.g.dart';

@Mapper(useInjection: true)
abstract class UserFromModelToEntityMapper extends EntityFromModelMapper<UserEntity, UserModel> {}

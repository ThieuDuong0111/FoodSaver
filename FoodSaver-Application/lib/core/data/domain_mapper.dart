import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';
import 'package:smartstruct/smartstruct.dart';

export 'package:injectable/injectable.dart';
export 'package:smartstruct/smartstruct.dart';

abstract class DomainMapper {}

abstract class EntityFromModelMapper<E extends DomainEntity, M extends DataModel> {
  @Mapping(target: 'copyWith', ignore: true)
  E? fromModel(M? model);
}

abstract class ModelFromEntityMapper<M extends DataModel, E extends DomainEntity> {
  @Mapping(target: 'copyWith', ignore: true)
  M? fromEntity(E? entity);
}

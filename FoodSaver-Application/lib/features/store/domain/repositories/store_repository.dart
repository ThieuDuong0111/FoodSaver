import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';

abstract class StoreRepository {
  Future<Either<Failure, List<UserEntity>>> listStoresPage();
}

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/store/data/datasources/store_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/store/domain/repositories/store_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: StoreRepository)
class StoreRepositoryImpl extends StoreRepository {
  StoreRepositoryImpl(this._storeRemoteDataSource);
  final StoreRemoteDataSource _storeRemoteDataSource;

  @override
  Future<Either<Failure, List<UserEntity>>> listStoresPage() async {
    return _storeRemoteDataSource.getListStores();
  }
}

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/store/domain/repositories/store_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ListStoresUsecase extends UseCaseHandleFailure<List<UserEntity>, NoParams> {
  ListStoresUsecase(this._storeRepository);

  final StoreRepository _storeRepository;

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) {
    return _storeRepository.listStoresPage();
  }
}

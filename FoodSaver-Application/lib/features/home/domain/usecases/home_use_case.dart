import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/domain/entities/home_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeUsecase extends UseCaseHandleFailure<HomeEntity, NoParams> {
  HomeUsecase(this._homeRepository);

  final HomeRepository _homeRepository;

  @override
  Future<Either<Failure, HomeEntity>> call(NoParams params) {
    return _homeRepository.homePage();
  }
}

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/data/datasources/home_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/domain/entities/home_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl(this._homeRemoteDataSource);
  final HomeRemoteDataSource _homeRemoteDataSource;

  @override
  Future<Either<Failure, HomeEntity>> homePage() async {
    return _homeRemoteDataSource.getHome();
  }
}

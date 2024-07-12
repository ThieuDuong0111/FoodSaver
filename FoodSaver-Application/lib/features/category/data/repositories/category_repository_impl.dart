import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/data/datasources/category_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/domain/entities/category_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/domain/repositories/category_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl extends CategoryRepository {
  CategoryRepositoryImpl(this._categoryRemoteDataSource);
  final CategoryRemoteDataSource _categoryRemoteDataSource;

  @override
  Future<Either<Failure, List<CategoryEntity>>> listCategoriesPage() async {
    return _categoryRemoteDataSource.getListCategories();
  }
}

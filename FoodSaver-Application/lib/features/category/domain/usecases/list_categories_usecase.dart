import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/domain/entities/category_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/domain/repositories/category_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ListCategoiresUsecase extends UseCaseHandleFailure<List<CategoryEntity>, NoParams> {
  ListCategoiresUsecase(this._categoryRepository);

  final CategoryRepository _categoryRepository;

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) {
    return _categoryRepository.listCategoriesPage();
  }
}

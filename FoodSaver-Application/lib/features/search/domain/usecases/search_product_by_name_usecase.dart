import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/search/domain/repositories/search_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SearchProductByNameUsecase extends UseCaseHandleFailure<List<ProductEntity>, String> {
  SearchProductByNameUsecase(this._searchRepository);

  final SearchRepository _searchRepository;

  @override
  Future<Either<Failure, List<ProductEntity>>> call(String params) {
    return _searchRepository.searchProductPage(params);
  }
}

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/search/data/datasources/search_product_by_name_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/search/domain/repositories/search_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl extends SearchRepository {
  SearchRepositoryImpl(this._searchProductByNameRemoteDataSource);
  final SearchProductByNameRemoteDataSource _searchProductByNameRemoteDataSource;

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProductPage(String productName) {
    return _searchProductByNameRemoteDataSource.getSearchProductByName(productName);
  }
}

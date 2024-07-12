import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/datasources/product_detail_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/repositories/product_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl(this._productRemoteDataSource);
  final ProductDetailRemoteDataSource _productRemoteDataSource;

  @override
  Future<Either<Failure, ProductEntity>> productDetailPage(int productId) async {
    return _productRemoteDataSource.getProductDetail(productId);
  }
}

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/repositories/product_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProductDetailUsecase extends UseCaseHandleFailure<ProductEntity, int> {
  ProductDetailUsecase(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Either<Failure, ProductEntity>> call(int params) {
    return _productRepository.productDetailPage(params);
  }
}

class ProductParams {
  final int productId;

  ProductParams({required this.productId});
}

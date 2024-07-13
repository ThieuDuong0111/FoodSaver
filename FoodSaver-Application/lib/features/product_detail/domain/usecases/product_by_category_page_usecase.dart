import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/repositories/product_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProductByCategoryUsecase extends UseCaseHandleFailure<List<ProductEntity>, int> {
  ProductByCategoryUsecase(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Either<Failure, List<ProductEntity>>> call(int params) {
    return _productRepository.productByCategoryPage(params);
  }
}

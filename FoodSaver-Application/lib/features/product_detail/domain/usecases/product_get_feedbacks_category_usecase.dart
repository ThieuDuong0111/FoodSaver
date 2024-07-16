import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/feedback_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/repositories/product_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProductGetFeedBacksUsecase extends UseCaseHandleFailure<List<FeedBackEntity>, int> {
  ProductGetFeedBacksUsecase(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Either<Failure, List<FeedBackEntity>>> call(int params) {
    return _productRepository.productGetFeedBacks(params);
  }
}

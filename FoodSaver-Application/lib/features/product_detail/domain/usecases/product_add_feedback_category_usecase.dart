import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/add_feedback_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/repositories/product_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProductAddFeedBackUsecase extends UseCaseHandleFailure<AddFeedBackRequest, AddFeedBackRequest> {
  ProductAddFeedBackUsecase(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Either<Failure, AddFeedBackRequest>> call(AddFeedBackRequest params) {
    return _productRepository.productAddFeedBack(params);
  }
}

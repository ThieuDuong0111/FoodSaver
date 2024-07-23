import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/add_answer_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/repositories/product_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProductAddAnswerUsecase extends UseCaseHandleFailure<AddAnswerRequest, AddAnswerRequest> {
  ProductAddAnswerUsecase(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Either<Failure, AddAnswerRequest>> call(AddAnswerRequest params) {
    return _productRepository.productAddAnswer(params);
  }
}

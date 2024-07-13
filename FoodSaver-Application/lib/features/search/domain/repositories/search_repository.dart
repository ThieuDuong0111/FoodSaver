import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<ProductEntity>>> searchProductPage(String productName);
}

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/add_feedback_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/feedback_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> productDetailPage(int productId);
  Future<Either<Failure, List<ProductEntity>>> productByCategoryPage(int categoryId);
  Future<Either<Failure, AddFeedBackRequest>> productAddFeedBack(AddFeedBackRequest addFeedBackRequest);
  Future<Either<Failure, List<FeedBackEntity>>> productGetFeedBacks(int productId);
}

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/datasources/product_add_answer_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/datasources/product_add_feedback_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/datasources/product_by_category_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/datasources/product_by_store_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/datasources/product_detail_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/data/datasources/product_get_feedbacks_remote_data_source.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/add_answer_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/add_feedback_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/feedback_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/repositories/product_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl(
    this._productRemoteDataSource,
    this._productByCategoryRemoteDataSource,
    this._productFeedBackRemoteDataSource,
    this._productGetFeedBacksRemoteDataSource,
    this._productByStoreRemoteDataSource,
    this._productAddAnswerRemoteDataSource,
  );
  final ProductDetailRemoteDataSource _productRemoteDataSource;
  final ProductByCategoryRemoteDataSource _productByCategoryRemoteDataSource;
  final ProductByStoreRemoteDataSource _productByStoreRemoteDataSource;
  final ProductAddFeedBackRemoteDataSource _productFeedBackRemoteDataSource;
  final ProductGetFeedBacksRemoteDataSource _productGetFeedBacksRemoteDataSource;
  final ProductAddAnswerRemoteDataSource _productAddAnswerRemoteDataSource;

  @override
  Future<Either<Failure, ProductEntity>> productDetailPage(int productId) async {
    return _productRemoteDataSource.getProductDetail(productId);
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> productByCategoryPage(int categoryId) {
    return _productByCategoryRemoteDataSource.getProductByCategory(categoryId);
  }

  @override
  Future<Either<Failure, AddFeedBackRequest>> productAddFeedBack(AddFeedBackRequest addFeedBackRequest) {
    return _productFeedBackRemoteDataSource.productAddFeedBack(addFeedBackRequest);
  }

  @override
  Future<Either<Failure, List<FeedBackEntity>>> productGetFeedBacks(int productId) {
    return _productGetFeedBacksRemoteDataSource.productGetFeedBacks(productId);
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> productByStorePage(int storeId) {
    return _productByStoreRemoteDataSource.getProductByStore(storeId);
  }

  @override
  Future<Either<Failure, AddAnswerRequest>> productAddAnswer(AddAnswerRequest addAnswerRequest) {
    return _productAddAnswerRemoteDataSource.productAddAnswer(addAnswerRequest);
  }
}

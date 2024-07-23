import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/add_answer_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/add_feedback_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/feedback_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/usecases/product_add_answer_category_usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/usecases/product_add_feedback_category_usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/usecases/product_by_category_usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/usecases/product_by_store_usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/usecases/product_detail_usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/usecases/product_get_feedbacks_category_usecase.dart';
import 'package:injectable/injectable.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

@injectable
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc(
    this._productDetailUsecase,
    this._productByCategoryUsecase,
    this._productAddFeedBackUsecase,
    this._productGetFeedBacksUsecase,
    this._productByStoreUsecase,
    this._productAddAnswerUsecase,
  ) : super(ProductDetailInitial()) {
    on<ProductDetailPageEvent>(_productDetailPage);
    on<ProductByCategoryPageEvent>(_producByCategoryPage);
    on<ProductByStorePageEvent>(_producByStorePage);
    on<ProductAddFeedBackEvent>(_productAddFeedBack);
    on<ProductGetFeedBacksEvent>(_productGetFeedBacks);
    on<ProductAddAnswerEvent>(_productAddAnswer);
  }

  final ProductDetailUsecase _productDetailUsecase;
  FutureOr<void> _productDetailPage(
    ProductDetailPageEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailPageLoadingState());
    final Either<Failure, ProductEntity> result = await _productDetailUsecase(event.productId);
    result.fold(
      (left) => emit(ProductDetailPageErrorState(failure: left)),
      (right) => emit(ProductDetailPageFinishedState(productEntity: right)),
    );
  }

  final ProductByCategoryUsecase _productByCategoryUsecase;
  FutureOr<void> _producByCategoryPage(
    ProductByCategoryPageEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductByCategoryPageLoadingState());
    final Either<Failure, List<ProductEntity>> result = await _productByCategoryUsecase(event.categoryId);
    result.fold(
      (left) => emit(ProductByCategoryPageErrorState(failure: left)),
      (right) => emit(ProductByCategoryPageFinishedState(listProductEntity: right)),
    );
  }

  final ProductByStoreUsecase _productByStoreUsecase;
  FutureOr<void> _producByStorePage(
    ProductByStorePageEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductByStorePageLoadingState());
    final Either<Failure, List<ProductEntity>> result = await _productByStoreUsecase(event.storeId);
    result.fold(
      (left) => emit(ProductByStorePageErrorState(failure: left)),
      (right) => emit(ProductByStorePageFinishedState(listProductEntity: right)),
    );
  }

  final ProductAddFeedBackUsecase _productAddFeedBackUsecase;
  FutureOr<void> _productAddFeedBack(
    ProductAddFeedBackEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductAddFeedBackLoadingState());
    final Either<Failure, AddFeedBackRequest> result = await _productAddFeedBackUsecase(event.addFeedBackRequest);
    result.fold(
      (left) => emit(ProductAddFeedBackErrorState(failure: left)),
      (right) => emit(ProductAddFeedBackFinishedState(addFeedBackRequest: right)),
    );
  }

  final ProductGetFeedBacksUsecase _productGetFeedBacksUsecase;
  FutureOr<void> _productGetFeedBacks(
    ProductGetFeedBacksEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductGetFeedBacksLoadingState());
    final Either<Failure, List<FeedBackEntity>> result = await _productGetFeedBacksUsecase(event.productId);
    result.fold(
      (left) => emit(ProductGetFeedBacksErrorState(failure: left)),
      (right) => emit(ProductGetFeedBacksFinishedState(listFeedBacksEntity: right)),
    );
  }

  final ProductAddAnswerUsecase _productAddAnswerUsecase;
  FutureOr<void> _productAddAnswer(
    ProductAddAnswerEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductAddAnswerLoadingState());
    final Either<Failure, AddAnswerRequest> result = await _productAddAnswerUsecase(event.addAnswerRequest);
    result.fold(
      (left) => emit(ProductAddAnswerErrorState(failure: left)),
      (right) => emit(ProductAddAnswerFinishedState(addAnswerRequest: right)),
    );
  }
}

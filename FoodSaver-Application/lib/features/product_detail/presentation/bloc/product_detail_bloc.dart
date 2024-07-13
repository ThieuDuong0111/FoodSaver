import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/usecases/product_by_category_usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/usecases/product_detail_usecase.dart';
import 'package:injectable/injectable.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

@injectable
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc(this._productDetailUsecase, this._productByCategoryUsecase) : super(ProductDetailInitial()) {
    on<ProductDetailPageEvent>(_productDetailPage);
    on<ProductByCategoryPageEvent>(_producByCategoryPage);
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
}

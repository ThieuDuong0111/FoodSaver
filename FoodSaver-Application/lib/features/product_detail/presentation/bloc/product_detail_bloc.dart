import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/usecases/product_detail_usecase.dart';
import 'package:injectable/injectable.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

@injectable
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc(this._productDetailUsecase) : super(ProductDetailInitial()) {
    on<ProductDetailPageEvent>(_productDetailPage);
  }

  final ProductDetailUsecase _productDetailUsecase;
  FutureOr<void> _productDetailPage(
    ProductDetailPageEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    final Either<Failure, ProductEntity> result = await _productDetailUsecase(event.productId);
    emit(ProductDetailPageLoadingState());
    result.fold(
      (left) => emit(ProductDetailPageErrorState(failure: left)),
      (right) => emit(ProductDetailPageFinishedState(productEntity: right)),
    );
  }
}

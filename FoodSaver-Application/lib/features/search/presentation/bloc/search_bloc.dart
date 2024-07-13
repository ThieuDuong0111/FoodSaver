import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/domain/entities/product_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/search/domain/usecases/search_product_by_name_usecase.dart';
import 'package:injectable/injectable.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._searchProductByNameUsecase) : super(SearchInitial()) {
    on<SearchByNamePageEvent>(_producByCategoryPage);
  }

  final SearchProductByNameUsecase _searchProductByNameUsecase;
  FutureOr<void> _producByCategoryPage(
    SearchByNamePageEvent event,
    Emitter<SearchState> emit,
  ) async {
    final Either<Failure, List<ProductEntity>> result = await _searchProductByNameUsecase(event.productName);
    emit(SearchByNamePageLoadingState());
    result.fold(
      (left) => emit(SearchByNamePageErrorState(failure: left)),
      (right) => emit(SearchByNamePageFinishedState(listProductEntity: right)),
    );
    return null;
  }
}

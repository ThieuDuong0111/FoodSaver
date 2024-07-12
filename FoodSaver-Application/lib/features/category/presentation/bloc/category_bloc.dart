import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/domain/entities/category_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/category/domain/usecases/list_categories_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

@injectable
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(this._listCategoiresUsecase) : super(CategoryInitial()) {
    on<CategoriesPageEvent>(_listCategoriesPage);
  }
  final ListCategoiresUsecase _listCategoiresUsecase;
  FutureOr<void> _listCategoriesPage(
    CategoriesPageEvent event,
    Emitter<CategoryState> emit,
  ) async {
    final Either<Failure, List<CategoryEntity>> result = await _listCategoiresUsecase(NoParams());
    emit(CategoriesPageLoadingState());
    result.fold(
      (left) => emit(CategoriesPageErrorState(failure: left)),
      (right) => emit(CategoriesPageFinishedState(listCategories: right)),
    );
    return null;
  }
}

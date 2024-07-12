part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoriesPageLoadingState extends CategoryState {}

class CategoriesPageErrorState extends CategoryState {
  const CategoriesPageErrorState({required this.failure});
  final Failure failure;
}

class CategoriesPageFinishedState extends CategoryState {
  const CategoriesPageFinishedState({
    required this.listCategories,
  });
  final List<CategoryEntity> listCategories;
}

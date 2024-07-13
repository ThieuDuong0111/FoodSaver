part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchByNamePageLoadingState extends SearchState {}

class SearchByNamePageErrorState extends SearchState {
  const SearchByNamePageErrorState({required this.failure});
  final Failure failure;
}

class SearchByNamePageFinishedState extends SearchState {
  const SearchByNamePageFinishedState({
    required this.listProductEntity,
  });
  final List<ProductEntity> listProductEntity;
}

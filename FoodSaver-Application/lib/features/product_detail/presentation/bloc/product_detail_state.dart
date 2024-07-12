part of 'product_detail_bloc.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailPageLoadingState extends ProductDetailState {}

class ProductDetailPageErrorState extends ProductDetailState {
  const ProductDetailPageErrorState({required this.failure});
  final Failure failure;
}

class ProductDetailPageFinishedState extends ProductDetailState {
  const ProductDetailPageFinishedState({
    required this.productEntity,
  });
  final ProductEntity productEntity;
}

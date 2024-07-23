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

class ProductByCategoryPageLoadingState extends ProductDetailState {}

class ProductByCategoryPageErrorState extends ProductDetailState {
  const ProductByCategoryPageErrorState({required this.failure});
  final Failure failure;
}

class ProductByCategoryPageFinishedState extends ProductDetailState {
  const ProductByCategoryPageFinishedState({
    required this.listProductEntity,
  });
  final List<ProductEntity> listProductEntity;
}

class ProductByStorePageLoadingState extends ProductDetailState {}

class ProductByStorePageErrorState extends ProductDetailState {
  const ProductByStorePageErrorState({required this.failure});
  final Failure failure;
}

class ProductByStorePageFinishedState extends ProductDetailState {
  const ProductByStorePageFinishedState({
    required this.listProductEntity,
  });
  final List<ProductEntity> listProductEntity;
}

class ProductAddFeedBackLoadingState extends ProductDetailState {}

class ProductAddFeedBackErrorState extends ProductDetailState {
  const ProductAddFeedBackErrorState({required this.failure});
  final Failure failure;
}

class ProductAddFeedBackFinishedState extends ProductDetailState {
  const ProductAddFeedBackFinishedState({
    required this.addFeedBackRequest,
  });
  final AddFeedBackRequest addFeedBackRequest;
}

class ProductGetFeedBacksLoadingState extends ProductDetailState {}

class ProductGetFeedBacksErrorState extends ProductDetailState {
  const ProductGetFeedBacksErrorState({required this.failure});
  final Failure failure;
}

class ProductGetFeedBacksFinishedState extends ProductDetailState {
  const ProductGetFeedBacksFinishedState({
    required this.listFeedBacksEntity,
  });
  final List<FeedBackEntity> listFeedBacksEntity;
}

class ProductAddAnswerLoadingState extends ProductDetailState {}

class ProductAddAnswerErrorState extends ProductDetailState {
  const ProductAddAnswerErrorState({required this.failure});
  final Failure failure;
}

class ProductAddAnswerFinishedState extends ProductDetailState {
  const ProductAddAnswerFinishedState({
    required this.addAnswerRequest,
  });
  final AddAnswerRequest addAnswerRequest;
}

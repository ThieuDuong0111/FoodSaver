part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class ProductDetailPageEvent extends ProductDetailEvent {
  const ProductDetailPageEvent(this.productId);
  final int productId;
}

class ProductByCategoryPageEvent extends ProductDetailEvent {
  const ProductByCategoryPageEvent(this.categoryId);
  final int categoryId;
}

class ProductAddFeedBackEvent extends ProductDetailEvent {
  const ProductAddFeedBackEvent(this.addFeedBackRequest);
  final AddFeedBackRequest addFeedBackRequest;
}

class ProductGetFeedBacksEvent extends ProductDetailEvent {
  const ProductGetFeedBacksEvent(this.productId);
  final int productId;
}

class ProductByStorePageEvent extends ProductDetailEvent {
  const ProductByStorePageEvent(this.storeId);
  final int storeId;
}

class ProductAddAnswerEvent extends ProductDetailEvent {
  const ProductAddAnswerEvent(this.addAnswerRequest);
  final AddAnswerRequest addAnswerRequest;
}

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

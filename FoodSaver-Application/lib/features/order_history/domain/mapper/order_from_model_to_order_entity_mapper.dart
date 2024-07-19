import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/data/models/order_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/entities/order_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/mapper/order_detail_from_model_to_order_detail_entity_mapper.dart';

abstract class OrderFromModelToEntityMapper {
  OrderEntity fromModel(OrderModel model);
}

@LazySingleton(as: OrderFromModelToEntityMapper)
class OrderFromModelToEntityMapperImpl extends OrderFromModelToEntityMapper {
  OrderFromModelToEntityMapperImpl(
    this._orderDetailFromModelToEntityMapper,
  ) : super();

  final OrderDetailFromModelToEntityMapper _orderDetailFromModelToEntityMapper;

  @override
  OrderEntity fromModel(OrderModel model) {
    final OrderEntity orderEntity = OrderEntity(
      id: model.id,
      orderDetails: model.orderDetails.map(_orderDetailFromModelToEntityMapper.fromModel).toList(),
      publishedDate: model.publishedDate,
      orderCode: model.orderCode,
      creatorName: model.creatorName,
      totalAmount: model.totalAmount,
      isPaid: model.isPaid,
      creator: UserEntity(
        id: model.creator.id,
        name: model.creator.name,
        imageUrl: model.creator.imageUrl,
        email: model.creator.email,
        phone: model.creator.phone,
        address: model.creator.address,
        storeName: model.creator.storeName,
        storeImageUrl: model.creator.storeImageUrl,
        storeDescription: model.creator.storeDescription,
      ),
      statusType: model.statusType,
      statusTypeParse: model.statusTypeParse,
      paymentType: model.paymentType,
      paymentTypeParse: model.paymentTypeParse,
    );
    return orderEntity;
  }
}

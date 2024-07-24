import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/entities/order_detail_entity.dart';

part 'order_entity.freezed.dart';

@freezed
class OrderEntity with _$OrderEntity implements DomainEntity {
  factory OrderEntity({
    required int id,
    required List<OrderDetailEntity?> orderDetails,
    required DateTime publishedDate,
    required String? orderCode,
    required String? creatorName,
    required int totalAmount,
    required bool isPaid,
    required UserEntity creator,
    required int statusType,
    required String statusTypeParse,
    required int paymentType,
    required String paymentTypeParse,
    required int shippingType,
  }) = _OrderEntity;
  OrderEntity._();
}

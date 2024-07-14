import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/domain/entities/order_detail_entity.dart';

part 'order_entity.freezed.dart';

@freezed
class OrderEntity with _$OrderEntity implements DomainEntity {
  factory OrderEntity({
    required int id,
    required List<OrderDetailEntity?> orderDetails,
    required DateTime publishedDate,
    required String? orderCode,
    required int totalAmount,
    required bool isPaid,
  }) = _OrderEntity;
  OrderEntity._();
}

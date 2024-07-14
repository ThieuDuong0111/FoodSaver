import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_entity.dart';

part 'order_detail_entity.freezed.dart';

@freezed
class OrderDetailEntity with _$OrderDetailEntity implements DomainEntity {
  factory OrderDetailEntity({
    required int id,
    required int productId,
    required String? productName,
    required String? productImage,
    required int unitQuantity,
    required int unitPrice,
  }) = _OrderDetailEntity;
  OrderDetailEntity._();
}

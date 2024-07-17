import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/data_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/data/models/user_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/order_history/data/models/order_detail_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel implements DataModel {
  factory OrderModel({
    required int id,
    required List<OrderDetailModel> orderDetails,
    required DateTime publishedDate,
    required String? orderCode,
    required String? creatorName,
    required int totalAmount,
    required bool isPaid,
    required UserModel creator,
    required int statusType,
    required String statusTypeParse,
    required int paymentType,
    required String paymentTypeParse,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
}

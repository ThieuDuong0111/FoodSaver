import 'package:json_annotation/json_annotation.dart';

part 'add_feedback_request.g.dart';

@JsonSerializable()
class AddFeedBackRequest {
  final int userId;
  final int productId;
  final String comment;
  final int rating;

  AddFeedBackRequest({
    required this.userId,
    required this.productId,
    required this.comment,
    required this.rating,
  });

  factory AddFeedBackRequest.fromJson(Map<String, dynamic> json) => _$AddFeedBackRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddFeedBackRequestToJson(this);
}

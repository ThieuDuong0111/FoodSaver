import 'package:json_annotation/json_annotation.dart';

part 'add_answer_request.g.dart';

@JsonSerializable()
class AddAnswerRequest {
  final int userId;
  final int feedBackId;
  final String answer;

  AddAnswerRequest({
    required this.userId,
    required this.feedBackId,
    required this.answer,
  });

  factory AddAnswerRequest.fromJson(Map<String, dynamic> json) => _$AddAnswerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddAnswerRequestToJson(this);
}

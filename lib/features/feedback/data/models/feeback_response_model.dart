import 'package:grad_ease/features/feedback/data/models/feedback_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feeback_response_model.g.dart';

@JsonSerializable()
class FeedbackResponseModel {
  final int statusCode;
  final String? message;
  final List<FeedbackModel> data;

  FeedbackResponseModel(
      {required this.statusCode, required this.message, required this.data});

  factory FeedbackResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackResponseModelToJson(this);
}

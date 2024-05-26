import 'package:grad_ease/features/feedback/domain/entity/feedback_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feedback_model.g.dart';

@JsonSerializable()
class FeedbackModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  final String message;
  final DateTime createdAt;

  FeedbackModel({
    required this.id,
    required this.name,
    required this.email,
    required this.message,
    required this.createdAt,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackModelToJson(this);

  FeedbackEntity toEntity() {
    return FeedbackEntity(
        id: id,
        name: name,
        email: email,
        message: message,
        createdAt: createdAt);
  }
}

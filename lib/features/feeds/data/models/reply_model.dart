import 'package:json_annotation/json_annotation.dart';

part 'reply_model.g.dart';

@JsonSerializable()
class ReplyModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? content;
  final String? author;

  ReplyModel({required this.id, required this.content, required this.author});

  factory ReplyModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyModelToJson(this);
}

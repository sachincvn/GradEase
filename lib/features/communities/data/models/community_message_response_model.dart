import 'package:grad_ease/features/communities/data/models/community_message_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community_message_response_model.g.dart';

@JsonSerializable()
class CommunityMessageResponseModel {
  final int statusCode;
  final String? message;
  final List<CommunityMessageModel> data;

  CommunityMessageResponseModel(
      {required this.statusCode, required this.message, required this.data});

  factory CommunityMessageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityMessageResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityMessageResponseModelToJson(this);
}

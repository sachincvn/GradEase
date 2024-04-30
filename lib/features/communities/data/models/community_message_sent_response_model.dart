import 'package:grad_ease/features/communities/data/models/community_message_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community_message_sent_response_model.g.dart';

@JsonSerializable()
class CommunityMessageSentResponseModel {
  final int statusCode;
  final String? message;
  final CommunityMessageModel data;

  CommunityMessageSentResponseModel(
      {required this.statusCode, required this.message, required this.data});

  factory CommunityMessageSentResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$CommunityMessageSentResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CommunityMessageSentResponseModelToJson(this);
}

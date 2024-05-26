import 'package:grad_ease/core/common/models/author_model.dart';
import 'package:grad_ease/features/communities/domain/entity/community_message_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community_message_model.g.dart';

@JsonSerializable()
class CommunityMessageModel {
  @JsonKey(name: '_id')
  final String id;
  final String communityId;
  final Author? sender;
  final String message;
  final String createdAt;

  CommunityMessageModel({
    required this.id,
    required this.communityId,
    required this.sender,
    required this.message,
    required this.createdAt,
  });

  CommunityMessageEntity toEntity() {
    return CommunityMessageEntity(
      id: id,
      communityId: communityId,
      sender: sender,
      message: message,
      createdAt: createdAt,
    );
  }

  factory CommunityMessageModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityMessageModelToJson(this);
}

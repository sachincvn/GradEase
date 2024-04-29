// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityMessageModel _$CommunityMessageModelFromJson(
        Map<String, dynamic> json) =>
    CommunityMessageModel(
      id: json['_id'] as String,
      communityId: json['communityId'] as String,
      sender: Author.fromJson(json['sender'] as Map<String, dynamic>),
      message: json['message'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$CommunityMessageModelToJson(
        CommunityMessageModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'communityId': instance.communityId,
      'sender': instance.sender,
      'message': instance.message,
      'createdAt': instance.createdAt,
    };

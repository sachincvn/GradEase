// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_message_sent_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityMessageSentResponseModel _$CommunityMessageSentResponseModelFromJson(
        Map<String, dynamic> json) =>
    CommunityMessageSentResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String?,
      data:
          CommunityMessageModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommunityMessageSentResponseModelToJson(
        CommunityMessageSentResponseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

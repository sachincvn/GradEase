// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_message_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityMessageResponseModel _$CommunityMessageResponseModelFromJson(
        Map<String, dynamic> json) =>
    CommunityMessageResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((e) => CommunityMessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommunityMessageResponseModelToJson(
        CommunityMessageResponseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedPostResponse _$FeedPostResponseFromJson(Map<String, dynamic> json) =>
    FeedPostResponse(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : FeedPostModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedPostResponseToJson(FeedPostResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

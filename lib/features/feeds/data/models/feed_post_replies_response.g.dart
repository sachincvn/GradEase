// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_post_replies_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedPostRepliesResponse _$FeedPostRepliesResponseFromJson(
        Map<String, dynamic> json) =>
    FeedPostRepliesResponse(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FeedPostReplyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedPostRepliesResponseToJson(
        FeedPostRepliesResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

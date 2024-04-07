// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_posts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedPostsResponse _$FeedPostsResponseFromJson(Map<String, dynamic> json) =>
    FeedPostsResponse(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : FeedPostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedPostsResponseToJson(FeedPostsResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

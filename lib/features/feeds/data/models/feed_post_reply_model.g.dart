// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_post_reply_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedPostReplyModel _$FeedPostReplyModelFromJson(Map<String, dynamic> json) =>
    FeedPostReplyModel(
      id: json['_id'] as String,
      content: json['content'] as String?,
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedPostReplyModelToJson(FeedPostReplyModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'author': instance.author,
    };

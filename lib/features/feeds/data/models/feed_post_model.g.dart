// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedPostModel _$FeedPostModelFromJson(Map<String, dynamic> json) =>
    FeedPostModel(
      id: json['_id'] as String,
      title: json['title'] as String?,
      content: json['content'] as String?,
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
      likedBy: (json['likedBy'] as List<dynamic>)
          .map((e) =>
              e == null ? null : Author.fromJson(e as Map<String, dynamic>))
          .toList(),
      dislikedBy: (json['dislikedBy'] as List<dynamic>)
          .map((e) =>
              e == null ? null : Author.fromJson(e as Map<String, dynamic>))
          .toList(),
      replies: (json['replies'] as List<dynamic>)
          .map((e) =>
              e == null ? null : ReplyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedPostModelToJson(FeedPostModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'author': instance.author,
      'likedBy': instance.likedBy,
      'dislikedBy': instance.dislikedBy,
      'replies': instance.replies,
    };

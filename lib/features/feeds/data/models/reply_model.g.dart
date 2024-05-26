// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyModel _$ReplyModelFromJson(Map<String, dynamic> json) => ReplyModel(
      id: json['_id'] as String?,
      content: json['content'] as String?,
      author: json['author'] as String?,
    );

Map<String, dynamic> _$ReplyModelToJson(ReplyModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'author': instance.author,
    };

import 'package:grad_ease/core/common/models/author_model.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_reply_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed_post_reply_model.g.dart';

@JsonSerializable()
class FeedPostReplyModel {
  @JsonKey(name: '_id')
  final String id;
  final String? content;
  final Author author;

  FeedPostReplyModel({
    required this.id,
    required this.content,
    required this.author,
  });

  FeedPostReplyEntity toEntity() {
    return FeedPostReplyEntity(content: content, author: author);
  }

  factory FeedPostReplyModel.fromJson(Map<String, dynamic> json) =>
      _$FeedPostReplyModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedPostReplyModelToJson(this);
}

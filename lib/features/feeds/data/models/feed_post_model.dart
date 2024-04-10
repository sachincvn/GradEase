import 'package:grad_ease/features/feeds/data/models/author_model.dart';
import 'package:grad_ease/features/feeds/data/models/reply_model.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed_post_model.g.dart';

@JsonSerializable()
class FeedPostModel {
  @JsonKey(name: '_id')
  final String id;
  final String? title;
  final String? content;
  final Author author;
  final List<Author?> likedBy;
  final List<Author?> dislikedBy;
  final List<ReplyModel?> replies;

  FeedPostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.likedBy,
    required this.dislikedBy,
    required this.replies,
  });

  FeedPostEntity toEntity() {
    return FeedPostEntity(
      id: id,
      title: title,
      content: content,
      author: author,
      likedBy: likedBy,
      dislikedBy: dislikedBy,
      replies: replies
    );
  }

  factory FeedPostModel.fromJson(Map<String, dynamic> json) =>
      _$FeedPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedPostModelToJson(this);
}

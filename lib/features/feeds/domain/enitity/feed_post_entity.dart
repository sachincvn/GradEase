// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grad_ease/core/common/models/author_model.dart';
import 'package:grad_ease/features/feeds/data/models/reply_model.dart';

class FeedPostEntity {
  final String id;
  final String? title;
  final String? content;
  final Author? author;
  final List<String?> likedBy;
  final List<String?> dislikedBy;
  final List<ReplyModel?>? replies;

  FeedPostEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.likedBy,
    required this.dislikedBy,
    required this.replies,
  });

  FeedPostEntity copyWith({
    String? id,
    String? title,
    String? content,
    Author? author,
    List<String?>? likedBy,
    List<String?>? dislikedBy,
    List<ReplyModel?>? replies,
    bool? isPostLiked,
    bool? isPostDisliked,
  }) {
    return FeedPostEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        author: author ?? this.author,
        likedBy: likedBy ?? this.likedBy,
        dislikedBy: dislikedBy ?? this.dislikedBy,
        replies: replies ?? this.replies);
  }
}

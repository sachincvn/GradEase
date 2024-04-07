import 'package:grad_ease/features/feeds/data/models/author_model.dart';

class FeedPostEntity {
  final String id;
  final String? title;
  final String? content;
  final Author? author;
  final List<Author?> likedBy;
  final List<Author?> dislikedBy;

  FeedPostEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.likedBy,
    required this.dislikedBy,
  });
}
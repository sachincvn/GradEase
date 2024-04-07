import 'package:grad_ease/features/feeds/data/models/feed_post_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed_posts_response.g.dart';

@JsonSerializable()
class FeedPostsResponse {
  final int statusCode;
  final String? message;
  final List<FeedPostModel?>? data;

  FeedPostsResponse(
      {required this.statusCode, required this.message, required this.data});

  factory FeedPostsResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedPostsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeedPostsResponseToJson(this);
}

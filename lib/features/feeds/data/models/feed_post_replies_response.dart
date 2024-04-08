import 'package:grad_ease/features/feeds/data/models/feed_post_reply_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed_post_replies_response.g.dart';

@JsonSerializable()
class FeedPostRepliesResponse {
  final int statusCode;
  final String? message;
  final List<FeedPostReplyModel>? data;

  FeedPostRepliesResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory FeedPostRepliesResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedPostRepliesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeedPostRepliesResponseToJson(this);
}

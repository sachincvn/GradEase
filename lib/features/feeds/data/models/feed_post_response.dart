import 'package:grad_ease/features/feeds/data/models/feed_post_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed_post_response.g.dart';

@JsonSerializable()
class FeedPostResponse {
  final int statusCode;
  final String? message;
  final FeedPostModel? data;

  FeedPostResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory FeedPostResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedPostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeedPostResponseToJson(this);
}

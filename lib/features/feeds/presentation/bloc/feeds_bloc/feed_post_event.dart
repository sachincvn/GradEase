part of 'feed_post_bloc.dart';

@immutable
sealed class FeedPostEvent {}

final class FetchAllPosts extends FeedPostEvent {}


final class LikePost extends FeedPostEvent{
  final String postId;

  LikePost(this.postId);
}

final class DislikePost extends FeedPostEvent{
  final String postId;

  DislikePost(this.postId);
}
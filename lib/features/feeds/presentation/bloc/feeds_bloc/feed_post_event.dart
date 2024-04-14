part of 'feed_post_bloc.dart';

@immutable
sealed class FeedPostEvent {}

final class FetchAllPosts extends FeedPostEvent {}

final class LikePostEvent extends FeedPostEvent {
  final FeedPostEntity feedPostEntity;

  LikePostEvent(this.feedPostEntity);
}

final class DislikePostEvent extends FeedPostEvent {
  final FeedPostEntity feedPostEntity;

  DislikePostEvent(this.feedPostEntity);
}

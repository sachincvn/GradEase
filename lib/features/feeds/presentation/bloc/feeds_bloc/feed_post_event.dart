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

final class InsertNewPostEvent extends FeedPostEvent {
  final FeedPostEntity feedPostEntity;

  InsertNewPostEvent(this.feedPostEntity);
}

final class RemovePostEvent extends FeedPostEvent {
  final String id;

  RemovePostEvent(this.id);
}

final class RefreshLatestFeed extends FeedPostEvent {}

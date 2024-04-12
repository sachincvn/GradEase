part of 'feed_post_item_bloc.dart';

@immutable
sealed class FeedPostItemEvent {}

final class LikePostEvent extends FeedPostItemEvent {
  final FeedPostEntity feedPostEntity;

  LikePostEvent(this.feedPostEntity);
}

final class DislikePostEvent extends FeedPostItemEvent {
  final String postId;

  DislikePostEvent(this.postId);
}

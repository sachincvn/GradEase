part of 'feed_post_item_bloc.dart';

@immutable
sealed class FeedPostItemEvent {}

final class FeedPostItemInital extends FeedPostItemEvent {
  final FeedPostEntity feedPost;

  FeedPostItemInital(this.feedPost);
}

final class LikePostEvent extends FeedPostItemEvent {
  final FeedPostEntity feedPostEntity;

  LikePostEvent(this.feedPostEntity);
}

final class DislikePostEvent extends FeedPostItemEvent {
  final String postId;

  DislikePostEvent(this.postId);
}

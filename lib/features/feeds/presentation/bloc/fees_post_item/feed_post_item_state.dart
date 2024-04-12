part of 'feed_post_item_bloc.dart';

@immutable
sealed class FeedPostItemState {}

final class FeedPostItemInitial extends FeedPostItemState {}

final class LikePostSuccess extends FeedPostItemState {
  final FeedPostEntity? feedPostEntity;

  LikePostSuccess(this.feedPostEntity);
}

final class LikePostFailure extends FeedPostItemState {
  final String error;

  LikePostFailure(this.error);
}

final class DisLikePostSuccess extends FeedPostItemState {
  final String? disliked;

  DisLikePostSuccess(this.disliked);
}

final class DisLikePostFailure extends FeedPostItemState {
  final String error;

  DisLikePostFailure(this.error);
}

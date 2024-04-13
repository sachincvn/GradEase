part of 'feed_post_item_bloc.dart';

@immutable
sealed class FeedPostItemState {}

final class FeedPostItemInitial extends FeedPostItemState {}

final class FeedPostItemSucess extends FeedPostItemState {
  final FeedPostEntity? feedPostEntity;

  FeedPostItemSucess(this.feedPostEntity);
}

final class FeedPostItemFailure extends FeedPostItemState {
  final String error;

  FeedPostItemFailure(this.error);
}

part of 'feed_post_bloc.dart';

@immutable
sealed class FeedPostState {}

final class FeedPostInitial extends FeedPostState {}

final class FeedLoading extends FeedPostState {}

final class FeedFailure extends FeedPostState {
  final String error;
  FeedFailure(this.error);
}

final class FeedDisplaySuccess extends FeedPostState {
  final List<FeedPostEntity?> posts;
  FeedDisplaySuccess(this.posts);
}


final class LikePostSuccess extends FeedPostState{
  final bool liked;

  LikePostSuccess(this.liked);
}

final class LikePostFailure extends FeedPostState{
  final String error;

  LikePostFailure(this.error);
}

final class DisLikePostSuccess extends FeedPostState{
  final bool disliked;

  DisLikePostSuccess(this.disliked);
}

final class DisLikePostFailure extends FeedPostState{
  final String error;

  DisLikePostFailure(this.error);
}
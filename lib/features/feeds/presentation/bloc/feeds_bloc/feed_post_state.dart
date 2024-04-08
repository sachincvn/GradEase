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

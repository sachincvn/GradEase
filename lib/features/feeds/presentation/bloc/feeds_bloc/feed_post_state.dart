part of 'feed_post_bloc.dart';

enum FeedPostStateStatus { initial, loading, success, error }

@immutable
class FeedPostState {
  final FeedPostStateStatus feedPostStateStatus;
  final List<FeedPostEntity?> posts;
  final String? errorMessage;

  const FeedPostState({
    this.feedPostStateStatus = FeedPostStateStatus.initial,
    this.posts = const [],
    this.errorMessage,
  });

  FeedPostState copyWith({
    FeedPostStateStatus? feedPostStateStatus,
    List<FeedPostEntity?>? posts,
    String? errorMessage,
  }) {
    return FeedPostState(
      feedPostStateStatus: feedPostStateStatus ?? this.feedPostStateStatus,
      posts: posts ?? this.posts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

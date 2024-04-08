part of 'feed_detail_bloc.dart';

@immutable
sealed class FeedDetailState {}

final class FeedDetailInitial extends FeedDetailState {}

final class FeedPostRepliesInitial extends FeedDetailState {}

final class FeedPostRepliesLoading extends FeedDetailState {}

final class FeedPostRepliesSuccess extends FeedDetailState {
  final List<FeedPostReplyEntity> postReplies;
  FeedPostRepliesSuccess({required this.postReplies});
}

final class FeedPostRepliesFailure extends FeedDetailState {
  final String error;
  FeedPostRepliesFailure(this.error);
}

final class FeedPostReplying extends FeedDetailState {}

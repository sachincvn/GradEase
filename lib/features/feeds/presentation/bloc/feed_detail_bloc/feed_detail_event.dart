part of 'feed_detail_bloc.dart';

@immutable
sealed class FeedDetailEvent {}

final class GetAllPostReplies extends FeedDetailEvent {
  final String postId;

  GetAllPostReplies({required this.postId});
}

final class AddNewReply extends FeedDetailEvent {
  final AddReplyUseCaseParams addReply;

  AddNewReply({required this.addReply});
}

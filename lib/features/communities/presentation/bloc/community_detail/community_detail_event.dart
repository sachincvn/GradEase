part of 'community_detail_bloc.dart';

@immutable
sealed class CommunityDetailEvent {}

final class FetchAllCommunityMessages extends CommunityDetailEvent {
  final String communityId;

  FetchAllCommunityMessages(this.communityId);
}

final class SendCommunityMessage extends CommunityDetailEvent {
  final String message;
  final String communityId;
  final List<CommunityMessageEntity?>? messages;

  SendCommunityMessage(
      {required this.message,
      required this.communityId,
      required this.messages});
}

final class FetchMoreCommunityMessages extends CommunityDetailEvent {
  final String communityId;
  final int page;
  final int pageLimit;

  FetchMoreCommunityMessages({
    required this.communityId,
    required this.page,
    required this.pageLimit,
  });
}

final class AddNewRecivedMessage extends CommunityDetailEvent {
  final CommunityMessageEntity communityMessageEntity;

  AddNewRecivedMessage(this.communityMessageEntity);
}

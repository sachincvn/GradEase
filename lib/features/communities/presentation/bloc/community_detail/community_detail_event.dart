part of 'community_detail_bloc.dart';

@immutable
sealed class CommunityDetailEvent {}

final class FetchAllCommunityMessages extends CommunityDetailEvent {
  final String communityId;

  FetchAllCommunityMessages(this.communityId);
}

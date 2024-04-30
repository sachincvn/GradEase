part of 'community_detail_bloc.dart';

enum CommunityDetailStateStatus { initial, loading, success, error }

@immutable
class CommunityDetailState {
  final CommunityDetailStateStatus communityDetailStateStatus;
  final List<CommunityMessageEntity?> messages;
  final bool hasMoreData;
  final String? errorMessage;
  final CommunityMessageEntity? sentMessageData;

  const CommunityDetailState({
    this.communityDetailStateStatus = CommunityDetailStateStatus.initial,
    this.messages = const [],
    this.hasMoreData = true,
    this.errorMessage,
    this.sentMessageData,
  });

  CommunityDetailState copyWith({
    CommunityDetailStateStatus? communityDetailStateStatus,
    List<CommunityMessageEntity?>? messages,
    bool? hasMoreData,
    String? errorMessage,
    CommunityMessageEntity? sentMessageData,
  }) {
    return CommunityDetailState(
        communityDetailStateStatus:
            communityDetailStateStatus ?? this.communityDetailStateStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        messages: messages ?? this.messages,
        hasMoreData: hasMoreData ?? this.hasMoreData,
        sentMessageData: sentMessageData ?? this.sentMessageData);
  }
}

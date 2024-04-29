part of 'community_detail_bloc.dart';

enum CommunityDetailStateStatus { initial, loading, success, error }

@immutable
class CommunityDetailState {
  final CommunityDetailStateStatus communityDetailStateStatus;
  final List<CommunityMessageEntity?> messages;
  final String? errorMessage;

  const CommunityDetailState({
    this.communityDetailStateStatus = CommunityDetailStateStatus.initial,
    this.messages = const [],
    this.errorMessage,
  });

  CommunityDetailState copyWith({
    CommunityDetailStateStatus? communityDetailStateStatus,
    List<CommunityMessageEntity?>? messages,
    String? errorMessage,
  }) {
    return CommunityDetailState(
      communityDetailStateStatus:
          communityDetailStateStatus ?? this.communityDetailStateStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      messages: messages ?? this.messages,
    );
  }
}

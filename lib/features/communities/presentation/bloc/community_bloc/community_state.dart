part of 'community_bloc.dart';

enum CommunityStateStatus { initial, loading, success, error }

@immutable
class CommunityState {
  final CommunityStateStatus communityStateStatus;
  final List<CommunityEntity?> communites;
  final String? errorMessage;

  const CommunityState({
    this.communityStateStatus = CommunityStateStatus.initial,
    this.communites = const [],
    this.errorMessage,
  });

  CommunityState copyWith({
    CommunityStateStatus? communityStateStatus,
    List<CommunityEntity?>? communites,
    String? errorMessage,
  }) {
    return CommunityState(
      communityStateStatus: communityStateStatus ?? this.communityStateStatus,
      communites: communites ?? this.communites,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

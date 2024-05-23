part of 'communites_bloc.dart';

enum CommunitesStateStatus { initial, loading, success, error }

@immutable
class CommunitesState {
  final CommunitesStateStatus status;
  final List<CommunityEntity?> communites;
  final String? errorMessage;

  const CommunitesState({
    this.status = CommunitesStateStatus.initial,
    this.communites = const [],
    this.errorMessage,
  });

  CommunitesState copyWith({
    CommunitesStateStatus? status,
    List<CommunityEntity?>? communites,
    String? errorMessage,
    bool? isPendinApprovalStudentsSelected,
  }) {
    return CommunitesState(
      status: status ?? this.status,
      communites: communites ?? this.communites,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

part of 'assignment_bloc.dart';

enum AssignmentStateStatus { initial, loading, success, error }

@immutable
class AssignmentState {
  final AssignmentStateStatus notesStateStatus;
  final List<AssignmentEntity?> assignments;
  final String? errorMessage;

  const AssignmentState({
    this.notesStateStatus = AssignmentStateStatus.initial,
    this.assignments = const [],
    this.errorMessage,
  });

  AssignmentState copyWith({
    AssignmentStateStatus? notesStateStatus,
    List<AssignmentEntity?>? assignments,
    String? errorMessage,
  }) {
    return AssignmentState(
      notesStateStatus: notesStateStatus ?? this.notesStateStatus,
      assignments: assignments ?? this.assignments,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

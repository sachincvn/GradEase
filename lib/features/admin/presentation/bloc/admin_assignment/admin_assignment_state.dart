part of 'admin_assignment_bloc.dart';

enum AdminAssignmnetStateStatus { initial, loading, success, error }

@immutable
class AdminAssignmnetState {
  final AdminAssignmnetStateStatus status;
  final List<AssignmentEntity> assignments;
  final String? errorMessage;

  const AdminAssignmnetState({
    this.status = AdminAssignmnetStateStatus.initial,
    this.assignments = const [],
    this.errorMessage,
  });

  AdminAssignmnetState copyWith({
    AdminAssignmnetStateStatus? status,
    List<AssignmentEntity>? assignments,
    String? errorMessage,
  }) {
    return AdminAssignmnetState(
      status: status ?? this.status,
      assignments: assignments ?? this.assignments,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

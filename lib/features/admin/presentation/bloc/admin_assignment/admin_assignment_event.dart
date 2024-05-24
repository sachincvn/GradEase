part of 'admin_assignment_bloc.dart';

@immutable
sealed class AdminAssignmnetEvent {}

final class FetchAllAdminAssignmnet extends AdminAssignmnetEvent {}

final class DeleteTimeAdminAssignmnet extends AdminAssignmnetEvent {
  final AssignmentEntity assignment;

  DeleteTimeAdminAssignmnet({required this.assignment});
}

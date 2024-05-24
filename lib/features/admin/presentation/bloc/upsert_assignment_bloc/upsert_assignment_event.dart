part of 'upsert_assignment_bloc.dart';

@immutable
sealed class UpsertAssignmentEvent {}

final class UpsertAssignment extends UpsertAssignmentEvent {
  final AssignmentEntity assignmentEntity;

  UpsertAssignment({required this.assignmentEntity});
}

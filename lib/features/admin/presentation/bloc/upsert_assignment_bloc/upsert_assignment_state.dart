part of 'upsert_assignment_bloc.dart';

@immutable
sealed class UpsertAssignmentState {}

final class UpsertAssignmentInitial extends UpsertAssignmentState {}

final class UpsertAssignmentLoadingState extends UpsertAssignmentState {}

final class UpsertAssignmentSuccessState extends UpsertAssignmentState {
  final AssignmentEntity assignmentEntity;
  UpsertAssignmentSuccessState(this.assignmentEntity);
}

final class UpsertAssignmentFailureState extends UpsertAssignmentState {
  final String? message;

  UpsertAssignmentFailureState(this.message);
}

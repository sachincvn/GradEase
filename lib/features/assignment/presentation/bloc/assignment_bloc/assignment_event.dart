part of 'assignment_bloc.dart';

@immutable
sealed class AssignmentEvent {}

final class FetchAssignmentEvent extends AssignmentEvent {}

final class OpenUrlEvent extends AssignmentEvent {
  final String url;

  OpenUrlEvent(this.url);
}

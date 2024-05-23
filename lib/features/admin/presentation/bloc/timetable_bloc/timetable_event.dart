part of 'timetable_bloc.dart';

@immutable
sealed class TimetableEvent {}

final class FetchAllTimeTable extends TimetableEvent {}

final class DeleteTimeTable extends TimetableEvent {
  final TimeTableModel timeTableModel;

  DeleteTimeTable({required this.timeTableModel});
}

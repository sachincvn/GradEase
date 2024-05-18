part of 'add_timetable_bloc.dart';

@immutable
sealed class AddTimetableEvent {}

final class SaveTimeTableEvent extends AddTimetableEvent {
  final TimeTableModel timeTableModel;

  SaveTimeTableEvent({required this.timeTableModel});
}

final class UpdateTimeTableEvent extends AddTimetableEvent {
  final TimeTableModel timeTableModel;

  UpdateTimeTableEvent({required this.timeTableModel});
}

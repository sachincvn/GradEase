part of 'add_timetable_bloc.dart';

@immutable
sealed class AddTimetableState {}

final class AddTimetableInitial extends AddTimetableState {}

final class AddTimetablLoadingState extends AddTimetableState {}

final class AddTimetablSuccessState extends AddTimetableState {
  final TimeTableEntity timeTable;
  AddTimetablSuccessState(this.timeTable);
}

final class AddTimetablFailureState extends AddTimetableState {
  final String? message;

  AddTimetablFailureState(this.message);
}

part of 'time_table_bloc.dart';

@immutable
sealed class TimeTableEvent {}

final class FetchTimeTable extends TimeTableEvent {
  final String? course;
  final int? year;
  final String? section;

  FetchTimeTable({
    this.course,
    this.year,
    this.section,
  });
}

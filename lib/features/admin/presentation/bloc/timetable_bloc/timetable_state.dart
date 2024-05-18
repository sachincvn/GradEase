part of 'timetable_bloc.dart';

enum TimetableStateStatus { initial, loading, success, error }

@immutable
class TimetableState {
  final TimetableStateStatus status;
  final List<TimeTableModel> timetables;
  final String? errorMessage;

  const TimetableState({
    this.status = TimetableStateStatus.initial,
    this.timetables = const [],
    this.errorMessage,
  });

  TimetableState copyWith({
    TimetableStateStatus? status,
    List<TimeTableModel>? timetables,
    String? errorMessage,
  }) {
    return TimetableState(
      status: status ?? this.status,
      timetables: timetables ?? this.timetables,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

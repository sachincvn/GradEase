part of 'time_table_bloc.dart';

enum TimeTableStateStatus { initial, loading, success, error }

@immutable
class TimeTableState {
  final TimeTableStateStatus timeTableStateStatus;
  final TimeTableEntity? timeTableEntity;
  final String? errorMessage;

  const TimeTableState({
    this.timeTableStateStatus = TimeTableStateStatus.initial,
    this.timeTableEntity,
    this.errorMessage,
  });

  TimeTableState copyWith({
    TimeTableStateStatus? timeTableStateStatus,
    TimeTableEntity? timeTableEntity,
    String? errorMessage,
  }) {
    return TimeTableState(
      timeTableStateStatus: timeTableStateStatus ?? this.timeTableStateStatus,
      timeTableEntity: timeTableEntity ?? this.timeTableEntity,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

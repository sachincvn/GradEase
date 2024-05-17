import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/timetable/domain/entity/time_table_entity.dart';
import 'package:grad_ease/features/timetable/domain/usecas/get_time_table_use_case.dart';
import 'package:intl/intl.dart';

part 'time_table_event.dart';
part 'time_table_state.dart';

class TimeTableBloc extends Bloc<TimeTableEvent, TimeTableState> {
  final GetTimeTableUseCase _getTimeTableUseCase;

  String currentDate = DateTime.now().day.toString();
  String currentDay = DateFormat('EEEE').format(DateTime.now());
  String currentMonthYear =
      DateFormat('MMMM yyyy').format(DateTime.now());


  TimeTableBloc(this._getTimeTableUseCase) : super(const TimeTableState()) {
    on<FetchTimeTable>(_onFetchTimeTable);
  }

  FutureOr<void> _onFetchTimeTable(
      FetchTimeTable event, Emitter<TimeTableState> emit) async {
    emit(const TimeTableState(
        timeTableStateStatus: TimeTableStateStatus.loading));

    final timeTable = await _getTimeTableUseCase(
      GetTimeTableParams(
          course: event.course, year: event.year, section: event.section),
    );
    timeTable.fold(
      (l) => emit(emitErrorState(l.message!)),
      (schedule) => emit(TimeTableState(
        timeTableStateStatus: TimeTableStateStatus.success,
        errorMessage: null,
        timeTableEntity: schedule,
      )),
    );
  }

  TimeTableState emitErrorState(String error) {
    return (state.copyWith(
      timeTableStateStatus: TimeTableStateStatus.error,
      errorMessage: error,
    ));
  }
}

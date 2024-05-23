import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/admin/domain/repository/admin_repository.dart';
import 'package:grad_ease/features/timetable/data/models/time_table_model.dart';

part 'timetable_event.dart';
part 'timetable_state.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  final AdminRepository _adminRepository;

  TimetableBloc(this._adminRepository) : super(const TimetableState()) {
    on<FetchAllTimeTable>(_onFetchAllTimeTable);
    on<DeleteTimeTable>(_onDeleteTimeTable);
  }

  FutureOr<void> _onFetchAllTimeTable(
      FetchAllTimeTable event, Emitter<TimetableState> emit) async {
    emit(state.copyWith(status: TimetableStateStatus.loading));
    final result = await _adminRepository.getAllTimeTable();
    result.fold(
      (failure) => emit(state.copyWith(
          status: TimetableStateStatus.error, errorMessage: failure.message)),
      (timetable) => emit(state.copyWith(
        status: TimetableStateStatus.success,
        timetables: timetable,
      )),
    );
  }

  FutureOr<void> _onDeleteTimeTable(
      DeleteTimeTable event, Emitter<TimetableState> emit) async {
    emit(state.copyWith(status: TimetableStateStatus.loading));
    final result = await _adminRepository.deleteTimeTable(event.timeTableModel);
    result.fold(
        (failure) => emit(state.copyWith(
            status: TimetableStateStatus.error,
            errorMessage: failure.message)), (timetable) {
      emit(state.copyWith(
        status: TimetableStateStatus.success,
        timetables: state.timetables
          ..removeWhere(
            (element) => element.id == event.timeTableModel.id,
          ),
      ));
    });
  }
}

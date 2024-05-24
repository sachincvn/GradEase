import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/admin/domain/repository/admin_repository.dart';
import 'package:grad_ease/features/assignment/domain/entity/assignment_entity.dart';

part 'admin_assignment_event.dart';
part 'admin_assignment_state.dart';

class AdminAssignmnetBloc
    extends Bloc<AdminAssignmnetEvent, AdminAssignmnetState> {
  final AdminRepository _adminRepository;

  AdminAssignmnetBloc(this._adminRepository)
      : super(const AdminAssignmnetState()) {
    on<FetchAllAdminAssignmnet>(_onFetchAllTimeTable);
    on<DeleteTimeAdminAssignmnet>(_onDeleteTimeTable);
  }

  FutureOr<void> _onFetchAllTimeTable(
      FetchAllAdminAssignmnet event, Emitter<AdminAssignmnetState> emit) async {
    emit(state.copyWith(status: AdminAssignmnetStateStatus.loading));
    final result = await _adminRepository.getAllAssignments();
    result.fold(
      (failure) => emit(state.copyWith(
          status: AdminAssignmnetStateStatus.error,
          errorMessage: failure.message)),
      (assignments) => emit(state.copyWith(
        status: AdminAssignmnetStateStatus.success,
        assignments: assignments,
      )),
    );
  }

  FutureOr<void> _onDeleteTimeTable(DeleteTimeAdminAssignmnet event,
      Emitter<AdminAssignmnetState> emit) async {
    emit(state.copyWith(status: AdminAssignmnetStateStatus.loading));
    final result = await _adminRepository.deleteAssignment(event.assignment.id);
    result.fold(
        (failure) => emit(state.copyWith(
            status: AdminAssignmnetStateStatus.error,
            errorMessage: failure.message)), (timetable) {
      emit(state.copyWith(
        status: AdminAssignmnetStateStatus.success,
        assignments: state.assignments
          ..removeWhere(
            (element) => element.id == event.assignment.id,
          ),
      ));
    });
  }
}

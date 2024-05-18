import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/admin/data/models/student_detail.dart';
import 'package:grad_ease/features/admin/domain/repository/admin_repository.dart';

part 'students_event.dart';
part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  final AdminRepository _adminRepository;
  List<StudentDetail> students = [];
  StudentsBloc(this._adminRepository) : super(const StudentsState()) {
    on<FetchAllStudents>(_onFetchAllStudents);
    on<FilterAllStudents>(_onFilterAlStudents);
    on<FilterPendingApprovalStudents>(_onFilterPendingApprovalStudents);
  }

  FutureOr<void> _onFetchAllStudents(
      FetchAllStudents event, Emitter<StudentsState> emit) async {
    emit(state.copyWith(status: StudentsStateStatus.loading));
    final students = await _adminRepository.getAllStudents();
    students.fold(
        (l) => emit(state.copyWith(
            status: StudentsStateStatus.error,
            errorMessage: l.message)), (result) {
      if (result.isNotEmpty) {
        this.students = result;
        final filterPendingApprovalStudents =
            result.where((element) => !(element.isApproved!)).toList();
        emit(
          state.copyWith(
            status: StudentsStateStatus.success,
            students: filterPendingApprovalStudents,
          ),
        );
      } else {
        state.copyWith(
          status: StudentsStateStatus.error,
          errorMessage: "No students found",
        );
      }
    });
  }

  FutureOr<void> _onFilterAlStudents(
      FilterAllStudents event, Emitter<StudentsState> emit) {
    if (students.isNotEmpty) {
      emit(
        state.copyWith(
          status: StudentsStateStatus.success,
          students: students,
          isPendinApprovalStudentsSelected: false,
        ),
      );
    } else {
      state.copyWith(
        status: StudentsStateStatus.error,
        errorMessage: "No students found",
      );
    }
  }

  FutureOr<void> _onFilterPendingApprovalStudents(
      FilterPendingApprovalStudents event, Emitter<StudentsState> emit) {
    if (students.isNotEmpty) {
      final filterPendingApprovalStudents =
          students.where((element) => !(element.isApproved!)).toList();
      emit(
        state.copyWith(
          status: StudentsStateStatus.success,
          students: filterPendingApprovalStudents,
          isPendinApprovalStudentsSelected: true,
        ),
      );
    } else {
      state.copyWith(
        status: StudentsStateStatus.error,
        errorMessage: "No students found",
      );
    }
  }
}

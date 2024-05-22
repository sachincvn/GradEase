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
    on<ApproveStudent>(_onApproveStudent);
    on<DeleteStudent>(_onDeleteStudent);
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
        emit(state.copyWith(
          status: StudentsStateStatus.error,
          errorMessage: "No students found",
        ));
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
      emit(state.copyWith(
        status: StudentsStateStatus.error,
        errorMessage: "No students found",
      ));
    }
  }

  FutureOr<void> _onFilterPendingApprovalStudents(
      FilterPendingApprovalStudents event, Emitter<StudentsState> emit) {
    emit(state.copyWith(status: StudentsStateStatus.loading));
    if (students.isNotEmpty) {
      final filterPendingApprovalStudents =
          students.where((element) => !(element.isApproved!)).toList();
      if (filterPendingApprovalStudents.isNotEmpty) {
        emit(
          state.copyWith(
            status: StudentsStateStatus.success,
            students: filterPendingApprovalStudents,
            isPendinApprovalStudentsSelected: true,
          ),
        );
      } else {
        emit(state.copyWith(
          status: StudentsStateStatus.error,
          isPendinApprovalStudentsSelected: true,
          errorMessage: "No students found",
        ));
      }
    } else {
      emit(state.copyWith(
        status: StudentsStateStatus.error,
        errorMessage: "No students found",
      ));
    }
  }

  FutureOr<void> _onApproveStudent(
      ApproveStudent event, Emitter<StudentsState> emit) async {
    emit(state.copyWith(status: StudentsStateStatus.loading));
    final updatedStudent =
        await _adminRepository.approveStudents(event.studentDetail.email!);
    updatedStudent.fold(
      (failure) => emit(state.copyWith(status: StudentsStateStatus.error)),
      (updatedStudent) {
        final List<StudentDetail?> updatedStudentsList =
            state.students.map((student) {
          if (student!.email == updatedStudent.email) {
            return updatedStudent;
          }
          return student;
        }).toList();

        emit(state.copyWith(
          status: StudentsStateStatus.success,
          students: updatedStudentsList,
        ));
      },
    );
  }

  FutureOr<void> _onDeleteStudent(
      DeleteStudent event, Emitter<StudentsState> emit) async {
    emit(state.copyWith(status: StudentsStateStatus.loading));
    final deletedStudent =
        await _adminRepository.deleteStudents(event.studentDetail.email!);
    deletedStudent.fold(
      (failure) => emit(state.copyWith(status: StudentsStateStatus.error)),
      (updatedStudent) {
        state.students.removeWhere(
            (element) => element!.email == event.studentDetail.email);

        emit(state.copyWith(
          status: StudentsStateStatus.success,
          students: state.students,
        ));
      },
    );
  }
}

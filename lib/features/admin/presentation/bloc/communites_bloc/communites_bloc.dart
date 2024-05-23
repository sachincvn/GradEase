import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/admin/data/models/student_detail.dart';
import 'package:grad_ease/features/admin/domain/repository/admin_repository.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';

part 'communites_event.dart';
part 'communites_state.dart';

class CommunitesBloc extends Bloc<CommunitesEvent, CommunitesState> {
  final AdminRepository _adminRepository;

  CommunitesBloc(this._adminRepository) : super(const CommunitesState()) {
    on<FetchAllCommunites>(_onFetchAllCommunites);
    on<DeleteStudent>(_onDeleteCommunity);
  }

  FutureOr<void> _onFetchAllCommunites(
      FetchAllCommunites event, Emitter<CommunitesState> emit) async {
    emit(state.copyWith(status: CommunitesStateStatus.loading));
    final communites = await _adminRepository.getAllCommunties();
    communites.fold(
        (l) => emit(state.copyWith(
            status: CommunitesStateStatus.error,
            errorMessage: l.message)), (result) {
      if (result.isNotEmpty) {
        emit(
          state.copyWith(
            status: CommunitesStateStatus.success,
            communites: result,
          ),
        );
      } else {
        emit(state.copyWith(
          status: CommunitesStateStatus.error,
          errorMessage: "No Communites found",
        ));
      }
    });
  }

  FutureOr<void> _onDeleteCommunity(
      DeleteStudent event, Emitter<CommunitesState> emit) async {
    emit(state.copyWith(status: CommunitesStateStatus.loading));
    // final deletedStudent =
    //     await _adminRepository.deleteStudents(event.studentDetail.email!);
    // deletedStudent.fold(
    //   (failure) => emit(state.copyWith(status: CommunitesStateStatus.error)),
    //   (updatedStudent) {
    //     state.students.removeWhere(
    //         (element) => element!.email == event.studentDetail.email);

    //     emit(state.copyWith(
    //       status: CommunitesStateStatus.success,
    //       students: state.students,
    //     ));
    //   },
    // );
  }
}

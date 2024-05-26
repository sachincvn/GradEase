import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/entities/auth_detail_enity.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/features/auth/domain/repository/auth_repository.dart';
import 'package:grad_ease/features/communities/presentation/bloc/community_bloc/community_bloc.dart';
import 'package:grad_ease/features/timetable/domain/entity/time_table_entity.dart';
import 'package:grad_ease/features/timetable/domain/usecase/get_time_table_use_case.dart';
import 'package:grad_ease/init_dependencies.dart';

part 'student_home_event.dart';
part 'student_home_state.dart';

class StudentHomeBloc extends Bloc<StudentHomeEvent, StudentHomeState> {
  final LocalDetailsRepository _localDetailsRepository;
  final GetTimeTableUseCase _getTimeTableUseCase;
  final AuthRepository _authRepository;

  AuthDetailEntity? studentEntity;
  TimeTableEntity? timetable;
  final CommunityBloc communityBloc = serviceLocator<CommunityBloc>();

  StudentHomeBloc(this._localDetailsRepository, this._getTimeTableUseCase,
      this._authRepository)
      : super(StudentHomeInitial()) {
    on<FetchInitalDataEvent>(_onFetchInitalDataEvent);
    on<FetchTimetableEvent>(_onFetchTimetableEvent);
    on<RefreshHomeData>(_onRefreshHomeData);
    on<GetStudentDataEvent>(_onGetStudentDataEvent);
  }

  Future<void> _onFetchInitalDataEvent(
      FetchInitalDataEvent event, Emitter<StudentHomeState> emit) async {
    try {
      emit(StudentHomeLoadingState());
      studentEntity = _localDetailsRepository.getStudentDetail();
      if (studentEntity != null) {
        emit(StudentHomeSuccessState(
          studentEntity: studentEntity!,
          toastMessage: null,
        ));
        add(FetchTimetableEvent());
      } else {
        emit(StudentHomeErrorState());
      }
    } catch (e) {
      emit(StudentHomeErrorState());
    }
  }

  Future<void> _onFetchTimetableEvent(
      FetchTimetableEvent event, Emitter<StudentHomeState> emit) async {
    try {
      final timetableEither = await _getTimeTableUseCase(GetTimeTableParams(
          course: studentEntity!.course!.name,
          year: studentEntity!.courseYear,
          section: studentEntity!.section));

      timetableEither.fold(
        (failure) => emit(StudentHomeSuccessState(
            studentEntity: studentEntity!, timeTableEntity: null)),
        (timetableData) {
          timetable = timetableData;
          emit(StudentHomeSuccessState(
            toastMessage: null,
            studentEntity: studentEntity!,
            timeTableEntity: timetable,
          ));
        },
      );
    } catch (e) {
      emit(StudentHomeErrorState());
    }
  }

  FutureOr<void> _onRefreshHomeData(
      RefreshHomeData event, Emitter<StudentHomeState> emit) {
    add(FetchInitalDataEvent());
    add(FetchTimetableEvent());
    communityBloc.add(FetchAllCommunites());
  }

  FutureOr<void> _onGetStudentDataEvent(
      GetStudentDataEvent event, Emitter<StudentHomeState> emit) async {
    try {
      final studentData = await _authRepository
          .getStudentDetail(_localDetailsRepository.getLoginDetail()!.email!);
      studentData.fold(
          (l) => emit(StudentHomeSuccessState(toastMessage: l.message)),
          (r) => emit(
              StudentHomeSuccessState(studentEntity: r, toastMessage: null)));
    } catch (e) {
      emit(StudentHomeSuccessState(toastMessage: e.toString()));
    }
  }
}

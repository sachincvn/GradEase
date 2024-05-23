import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/entities/student_enity.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/features/communities/presentation/bloc/community_bloc/community_bloc.dart';
import 'package:grad_ease/features/timetable/domain/entity/time_table_entity.dart';
import 'package:grad_ease/features/timetable/domain/usecase/get_time_table_use_case.dart';
import 'package:grad_ease/init_dependencies.dart';

part 'student_home_event.dart';
part 'student_home_state.dart';

class StudentHomeBloc extends Bloc<StudentHomeEvent, StudentHomeState> {
  final LocalDetailsRepository _localDetailsRepository;
  final GetTimeTableUseCase _getTimeTableUseCase;
  StudentEntity? studentEntity;
  TimeTableEntity? timetable;
  final CommunityBloc communityBloc = serviceLocator<CommunityBloc>();

  StudentHomeBloc(this._localDetailsRepository, this._getTimeTableUseCase)
      : super(StudentHomeInitial()) {
    on<FetchInitalDataEvent>(_onFetchInitalDataEvent);
    on<FetchTimetableEvent>(_onFetchTimetableEvent);
    on<RefreshHomeData>(_onRefreshHomeData);
  }

  Future<void> _onFetchInitalDataEvent(
      FetchInitalDataEvent event, Emitter<StudentHomeState> emit) async {
    try {
      emit(StudentHomeLoadingState());
      studentEntity = _localDetailsRepository.getStudentDetail();
      if (studentEntity != null) {
        emit(StudentHomeSuccessState(studentEntity: studentEntity!));
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
              studentEntity: studentEntity!, timeTableEntity: timetable));
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
}

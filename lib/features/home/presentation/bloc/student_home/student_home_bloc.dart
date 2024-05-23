import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/entities/student_enity.dart';
import 'package:grad_ease/core/local/local_repository.dart';

part 'student_home_event.dart';
part 'student_home_state.dart';

class StudentHomeBloc extends Bloc<StudentHomeEvent, StudentHomeState> {
  final LocalDetailsRepository _localDetailsRepository;
  StudentEntity? studentEntity;

  StudentHomeBloc(this._localDetailsRepository) : super(StudentHomeInitial()) {
    on<FetchInitalDataEvent>(_onFetchInitalDataEvent);
  }

  FutureOr<void> _onFetchInitalDataEvent(
      FetchInitalDataEvent event, Emitter<StudentHomeState> emit) {
    try {
      emit(StudentHomeLoadingState());
      studentEntity = _localDetailsRepository.getStudentDetail();
      if (studentEntity != null) {
        emit(StudentHomeSuccessState(studentEntity: studentEntity!));
      } else {
        emit(StudentHomeErrorState());
      }
    } catch (e) {
      emit(StudentHomeErrorState());
    }
  }
}

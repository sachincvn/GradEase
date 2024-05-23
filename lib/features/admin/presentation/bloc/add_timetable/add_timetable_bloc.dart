import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/admin/domain/repository/admin_repository.dart';
import 'package:grad_ease/features/timetable/data/models/time_table_model.dart';
import 'package:grad_ease/features/timetable/domain/entity/time_table_entity.dart';

part 'add_timetable_event.dart';
part 'add_timetable_state.dart';

class AddTimetableBloc extends Bloc<AddTimetableEvent, AddTimetableState> {
  final AdminRepository _adminRepository;

  AddTimetableBloc(this._adminRepository) : super(AddTimetableInitial()) {
    on<SaveTimeTableEvent>(_onSaveTimeTableEvent);
    on<UpdateTimeTableEvent>(_onUpdateTimeTableEvent);
  }

  FutureOr<void> _onSaveTimeTableEvent(
      SaveTimeTableEvent event, Emitter<AddTimetableState> emit) async {
    emit(AddTimetablLoadingState());
    final postId = await _adminRepository.addTimeTable(event.timeTableModel);
    postId.fold(
      (failure) => emit(AddTimetablFailureState(failure.message!)),
      (post) => emit(AddTimetablSuccessState(post)),
    );
  }

  FutureOr<void> _onUpdateTimeTableEvent(
      UpdateTimeTableEvent event, Emitter<AddTimetableState> emit) async {
    emit(AddTimetablLoadingState());
    final postId = await _adminRepository.updateTimeTable(event.timeTableModel);
    postId.fold(
      (failure) => emit(AddTimetablFailureState(failure.message!)),
      (post) => emit(AddTimetablSuccessState(post)),
    );
  }
}

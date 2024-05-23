import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/local/local_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LocalDetailsRepository _localDetailsRepository;
  ProfileBloc(this._localDetailsRepository) : super(ProfileInitial()) {
    on<StudentLogoutEvent>(_onStudentLogoutEvent);
  }

  FutureOr<void> _onStudentLogoutEvent(
    StudentLogoutEvent event,
    Emitter<ProfileState> emit,
  ) {
    try {
      _localDetailsRepository.clearAllLocalData();
      emit(ProfileSuccessState());
    } catch (e) {
      emit(ProfileErrorState(message: e.toString()));
    }
  }
}

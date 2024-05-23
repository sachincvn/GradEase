import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/constants/string_contants.dart';
import 'package:grad_ease/core/local/local_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LocalDetailsRepository _localDetailsRepository;
  String studentName = "";
  String studentEmail = "";
  String studentProfile = StringConstants.defaultAvatar;

  ProfileBloc(this._localDetailsRepository) : super(ProfileInitial()) {
    on<StudentLogoutEvent>(_onStudentLogoutEvent);
    on<FetchProfileStudentDetailEvent>(_onFetchStudentDetailEvent);
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

  FutureOr<void> _onFetchStudentDetailEvent(
      FetchProfileStudentDetailEvent event, Emitter<ProfileState> emit) {
    emit(ProfileLoadingState());
    try {
      final studentDetail = _localDetailsRepository.getStudentDetail();
      studentEmail = studentDetail!.email ?? "";
      studentName = studentDetail.fullName;
      studentProfile =
          studentDetail.profileImage ?? StringConstants.defaultAvatar;
      emit(ProfileLoadedState(
          studentName: studentName,
          studentEmail: studentEmail,
          studentProfile: studentProfile));
    } catch (e) {
      emit(ProfileErrorState(message: e.toString()));
    }
  }
}

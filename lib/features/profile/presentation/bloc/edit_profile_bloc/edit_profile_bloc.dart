import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/entities/student_enity.dart';
import 'package:grad_ease/core/constants/string_contants.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/features/profile/domain/repository/profile_repository.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final LocalDetailsRepository _localDetailsRepository;
  final ProfileRepository _profileRepository;
  AuthDetailEntity? studentEntity;
  EditProfileBloc(this._localDetailsRepository, this._profileRepository)
      : super(EditProfileInitial()) {
    on<UpdateStudentEvent>(_onUpdateStudentEvent);
    on<FetchStudentDetailEvent>(_onFetchStudentDetailEvent);
  }

  FutureOr<void> _onUpdateStudentEvent(
      UpdateStudentEvent event, Emitter<EditProfileState> emit) async {
    try {
      String profileImage;
      emit(UpdatingProfileState());

      if (_localDetailsRepository.getStudentDetail()!.profileImage ==
          event.profileImage) {
        profileImage =
            _localDetailsRepository.getStudentDetail()!.profileImage!;
      } else {
        final uploadImage = await _profileRepository.uploadStudentProfile(
            event.profileImage, event.profileImage);
        if (uploadImage != null && uploadImage.filePath.isNotEmpty) {
          profileImage = uploadImage.filePath;
        } else {
          profileImage = StringConstants.defaultAvatar;
        }
      }
      if (profileImage.isNotEmpty) {
        final updateStudent = await _profileRepository.updateStudentData(
          event.fullName,
          event.fatherName,
          event.dob,
          event.gender,
          event.course,
          event.year,
          event.section,
          event.email,
          event.studentPhone,
          event.parentPhone,
          profileImage,
        );
        updateStudent.fold(
          (l) => emit(EditProfileFailureSate(l.message!)),
          (r) => emit(EditProfileSuccessState()),
        );
      } else {
        emit(EditProfileFailureSate("Unable to update the profile"));
      }
    } catch (e) {
      emit(EditProfileFailureSate(e.toString()));
    }
  }

  FutureOr<void> _onFetchStudentDetailEvent(
      FetchStudentDetailEvent event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());
    try {
      studentEntity = _localDetailsRepository.getStudentDetail();
      if (studentEntity != null) {
        emit(StudentDataSuccessState());
      } else {
        emit(EditProfileFailureSate("Failed to fetch student details"));
      }
    } catch (e) {
      emit(EditProfileFailureSate(e.toString()));
    }
  }
}

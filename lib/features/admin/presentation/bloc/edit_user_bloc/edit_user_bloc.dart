import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/admin/domain/repository/admin_repository.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  final AdminRepository _adminRepository;
  EditUserBloc(this._adminRepository) : super(EditUserInitial()) {
    on<UpdateUserEvent>(_onUpdateUserEvent);
  }

  FutureOr<void> _onUpdateUserEvent(
      UpdateUserEvent event, Emitter<EditUserState> emit) async {
    try {
      emit(EditUserUpdatingState());
      final updateStudent = await _adminRepository.updateStudentData(
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
        event.profileImage,
        event.role,
      );
      updateStudent.fold(
        (l) => emit(EditUserErrorState(l.message!)),
        (r) => emit(EditUserSuccessState()),
      );
    } catch (e) {
      emit(EditUserErrorState(e.toString()));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/entities/student_enity.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void adminLogin() {
    emit(AppAdminLogedIn());
  }

  void updateUser(AuthDetailEntity? studentEntity) {
    if (studentEntity == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(studentEntity));
    }
  }
}

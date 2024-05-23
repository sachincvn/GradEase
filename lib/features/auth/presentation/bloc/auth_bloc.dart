import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/cubit/app_user_cubit.dart';
import 'package:grad_ease/core/common/entities/student_enity.dart';
import 'package:grad_ease/features/auth/domain/usecase/admin_login_usecase.dart';
import 'package:grad_ease/features/auth/domain/usecase/register_student_use_case.dart';
import 'package:grad_ease/features/auth/domain/usecase/student_login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final StudentLoginUseCase _studentLoginUseCase;
  final AdminLoginUseCase _adminLoginUseCase;
  final RegisterStudentUseCase _registerStudentUseCase;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required StudentLoginUseCase studentLoginUseCase,
    required AppUserCubit appUserCubit,
    required AdminLoginUseCase adminLoginUseCase,
    required RegisterStudentUseCase registerStudentUseCase,
  })  : _studentLoginUseCase = studentLoginUseCase,
        _appUserCubit = appUserCubit,
        _adminLoginUseCase = adminLoginUseCase,
        _registerStudentUseCase = registerStudentUseCase,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignIn>(onAuthSignIn);
    on<AuthAdminSignIn>(_onAdminSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<RegisterStudentEvent>(_onRegisterStudentEvent);
  }

  Future<void> onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final response = await _studentLoginUseCase(
        LoginParams(email: event.email, password: event.password),
      );
      response.fold(
        (failure) => emit(AuthFailure(message: failure.message!)),
        (data) async {
          if (data == null) {
            emit(const AuthFailure(message: "Unable to login !"));
            return;
          }
          if (data.isApproved!) {
            _emitAuthSuccess(data, emit);
          }
        },
      );
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  FutureOr<void> _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) {
    try {
      if (_studentLoginUseCase.loginAuthToken() == null &&
          _adminLoginUseCase.adminAuthToken() == null) {
        emit(AuthInitial());
      } else if (_adminLoginUseCase.isAdminLogedIn() != null &&
          (_adminLoginUseCase.isAdminLogedIn() ?? false)) {
        _appUserCubit.adminLogin();
        emit(AdminAuthSuccess());
      } else if (_studentLoginUseCase.studentDetail() != null) {
        final studentDetail = _studentLoginUseCase.studentDetail();
        _emitAuthSuccess(studentDetail!, emit);
      }
    } catch (e) {
      emit(AuthInitial());
    }
  }

  void _emitAuthSuccess(
    StudentEntity student,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(student);
    emit(StudentAuthSuccess(studentEntity: student));
  }

  FutureOr<void> _onAdminSignIn(
      AuthAdminSignIn event, Emitter<AuthState> emit) async {
    try {
      final response = await _adminLoginUseCase(
          LoginParams(email: event.email, password: event.password));
      response.fold((l) => emit(AuthFailure(message: l.message!)), (r) {
        _adminLoginUseCase.updateLocalAdminLogin();
        emit(AdminAuthSuccess());
        _appUserCubit.adminLogin();
      });
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  FutureOr<void> _onRegisterStudentEvent(
      RegisterStudentEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthRegisterLoading());
      final response = await _registerStudentUseCase(RegisterStudentParams(
        fullName: event.fullName,
        fatherName: event.fatherName,
        dob: event.dob,
        gender: event.gender,
        course: event.course,
        email: event.email,
        studentPhone: event.studentPhone,
        parentPhone: event.parentPhone,
        password: event.password,
        profileImage: event.profileImage,
      ));
      response.fold(
          (l) => emit(AuthRegisteredFailureState(l.message)),
          (r) => emit(const AuthRegisteredSuccessState(
              "Registered successfully! inform admin for approval")));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}

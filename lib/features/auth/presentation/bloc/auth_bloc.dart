import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/cubit/app_user_cubit.dart';
import 'package:grad_ease/core/common/entities/student_enity.dart';
import 'package:grad_ease/features/auth/domain/usecase/student_login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final StudentLoginUseCase _studentLoginUseCase;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required StudentLoginUseCase studentLoginUseCase,
    required AppUserCubit appUserCubit,
  })  : _studentLoginUseCase = studentLoginUseCase,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignIn>(onAuthSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  Future<void> onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final response = await _studentLoginUseCase(
      StudentLoginParams(email: event.email, password: event.password),
    );

    response.fold(
      (failure) => emit(AuthFailure(message: failure.message!)),
      (data) async {
        if (data == null) {
          emit(const AuthFailure(message: "Unable to login !"));
          return;
        }
        _emitAuthSuccess(data, emit);
      },
    );
  }

  FutureOr<void> _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) {
    if (_studentLoginUseCase.loginAuthToken() != null) {
      final studentDetail = _studentLoginUseCase.studentDetail();
      _emitAuthSuccess(studentDetail!, emit);
    }
    emit(AuthInitial());
  }

  void _emitAuthSuccess(
    StudentEntity student,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(student);
    emit(StudentAuthSuccess(studentEntity: student));
  }
}

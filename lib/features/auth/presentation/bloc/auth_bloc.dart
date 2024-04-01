import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/auth/domain/usecase/student_login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final StudentLoginUseCase _studentLoginUseCase;

  AuthBloc({required StudentLoginUseCase studentLoginUseCase})
      : _studentLoginUseCase = studentLoginUseCase,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignIn>(onAuthSignIn);
  }

  FutureOr<void> onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final response = await _studentLoginUseCase(
      StudentLoginParams(email: event.email, password: event.password),
    );

    response.fold(
      (l) => emit(AuthFailure(message: l.message!)),
      (r) => emit(AuthSuccess(authToken: r.data!)),
    );
  }
}

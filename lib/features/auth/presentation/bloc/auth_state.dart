part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class StudentAuthSuccess extends AuthState {
  final StudentEntity studentEntity;
  const StudentAuthSuccess({required this.studentEntity});
}

final class AdminAuthSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
}

final class AuthRegisterLoading extends AuthState {}

final class AuthRegisteredSuccessState extends AuthState {
  final String? message;

  const AuthRegisteredSuccessState(this.message);
}

final class AuthRegisteredFailureState extends AuthState {
  final String? message;

  const AuthRegisteredFailureState(this.message);
}

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

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
}

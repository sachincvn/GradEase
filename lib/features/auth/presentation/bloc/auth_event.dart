part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn({required this.email, required this.password});
}

final class AuthAdminSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthAdminSignIn({required this.email, required this.password});
}

final class AuthIsUserLoggedIn extends AuthEvent {}

final class RegisterStudentEvent extends AuthEvent {
  final String fullName;
  final String fatherName;
  final DateTime dob;
  final String gender;
  final String course;
  final String email;
  final String studentPhone;
  final String parentPhone;
  final String password;
  final String profileImage;

  RegisterStudentEvent({
    required this.fullName,
    required this.fatherName,
    required this.dob,
    required this.gender,
    required this.course,
    required this.email,
    required this.studentPhone,
    required this.parentPhone,
    required this.password,
    required this.profileImage,
  });
}

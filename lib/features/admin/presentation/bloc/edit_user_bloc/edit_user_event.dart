part of 'edit_user_bloc.dart';

@immutable
sealed class EditUserEvent {}

final class UpdateUserEvent extends EditUserEvent {
  final String fullName;
  final String fatherName;
  final DateTime dob;
  final String gender;
  final String course;
  final String email;
  final String studentPhone;
  final String parentPhone;
  final String profileImage;
  final String role;
  final int year;
  final String section;

  UpdateUserEvent({
    required this.fullName,
    required this.fatherName,
    required this.dob,
    required this.gender,
    required this.course,
    required this.email,
    required this.studentPhone,
    required this.parentPhone,
    required this.profileImage,
    required this.year,
    required this.section,
    required this.role,
  });
}

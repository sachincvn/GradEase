part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

final class FetchStudentDetailEvent extends EditProfileEvent {}

final class UpdateStudentEvent extends EditProfileEvent {
  final String fullName;
  final String fatherName;
  final DateTime dob;
  final String gender;
  final String course;
  final String email;
  final String studentPhone;
  final String parentPhone;
  final String profileImage;
  final int year;
  final String section;

  UpdateStudentEvent({
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
  });
}

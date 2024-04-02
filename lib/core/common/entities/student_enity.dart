import 'package:grad_ease/features/auth/data/models/student_model.dart';

class StudentEntity {
  final String fullName;
  final String fatherName;
  final DateTime dob;
  final GenderEnum gender;
  final CourseEnum course;
  final int courseYear;
  final String email;
  final String studentPhone;
  final String parentPhone;

  StudentEntity({
    required this.fullName,
    required this.fatherName,
    required this.dob,
    required this.gender,
    required this.course,
    required this.courseYear,
    required this.email,
    required this.studentPhone,
    required this.parentPhone,
  });
}

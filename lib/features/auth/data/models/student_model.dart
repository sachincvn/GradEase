// ignore_for_file: constant_identifier_names

import 'package:grad_ease/features/auth/domain/enitites/student_enity.dart';

enum GenderEnum { MALE, FEMALE, OTHER }

enum CourseEnum { MCA, MBA } // Define your CourseEnum

class StudentModel extends StudentEntity {
  StudentModel({
    required super.fullName,
    required super.fatherName,
    required super.dob,
    required super.gender,
    required super.course,
    required super.courseYear,
    required super.email,
    required super.studentPhone,
    required super.parentPhone,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      fullName: json['fullName'],
      fatherName: json['fatherName'],
      dob: DateTime.parse(json['dob']),
      gender: _parseGender(json['gender']),
      course: _parseCourse(json['course']),
      courseYear: json['courseYear'],
      email: json['email'],
      studentPhone: json['studentPhone'],
      parentPhone: json['parentPhone'],
    );
  }

  static GenderEnum _parseGender(String gender) {
    switch (gender) {
      case 'Male':
        return GenderEnum.MALE;
      case 'Female':
        return GenderEnum.FEMALE;
      case 'Other':
        return GenderEnum.OTHER;
      default:
        throw Exception('Invalid gender value: $gender');
    }
  }

  static CourseEnum _parseCourse(String course) {
    switch (course) {
      case 'MCA':
        return CourseEnum.MCA;
      case 'MBA':
        return CourseEnum.MBA;
      default:
        throw Exception('Invalid course value: $course');
    }
  }
}

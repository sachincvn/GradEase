// ignore_for_file: constant_identifier_names

import 'package:grad_ease/core/common/entities/student_enity.dart';

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
    required super.profileImage,
  });

  factory StudentModel.fromMap(Map<String, dynamic> json) {
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
      profileImage: json['profileImage'] ??
          "https://cdn-icons-png.freepik.com/512/7088/7088431.png?filename=teen_7088431.png&fd=1",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'fatherName': fatherName,
      'dob': dob!.toIso8601String(),
      'gender': gender?.name,
      'course': course?.name,
      'courseYear': courseYear,
      'email': email,
      'studentPhone': studentPhone,
      'parentPhone': parentPhone,
      'profileImage': profileImage,
    };
  }

  static GenderEnum _parseGender(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return GenderEnum.MALE;
      case 'female':
        return GenderEnum.FEMALE;
      case 'other':
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

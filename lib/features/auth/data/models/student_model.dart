// ignore_for_file: constant_identifier_names

import 'package:grad_ease/core/common/entities/auth_detail_enity.dart';

enum GenderEnum { MALE, FEMALE, OTHER }

enum CourseEnum { MCA, MBA }

enum RoleEnum { Student, Admin, Teacher }

class AuthLoginDetailModel {
  final String id;
  final String fullName;
  final String? fatherName;
  final DateTime? dob;
  final GenderEnum? gender;
  final CourseEnum? course;
  final int? courseYear;
  final String? email;
  final String? studentPhone;
  final String? parentPhone;
  final String? profileImage;
  final String? section;
  final bool? isApproved;
  final RoleEnum? role;

  AuthLoginDetailModel({
    required this.id,
    required this.fullName,
    required this.fatherName,
    required this.dob,
    required this.gender,
    required this.course,
    required this.courseYear,
    required this.email,
    required this.studentPhone,
    required this.parentPhone,
    required this.profileImage,
    required this.isApproved,
    required this.section,
    required this.role,
  });

  factory AuthLoginDetailModel.fromMap(Map<String, dynamic> json) {
    return AuthLoginDetailModel(
      id: json['_id'],
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
      section: json['section'],
      isApproved: json['isApproved'],
      role: _parseRole(json['role']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
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
      'isApproved': isApproved,
      'section': section,
      'role': role?.name
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

  static RoleEnum _parseRole(String course) {
    switch (course) {
      case 'Student':
        return RoleEnum.Student;
      case 'Admin':
        return RoleEnum.Admin;
      case 'Teacher':
        return RoleEnum.Teacher;
      default:
        throw Exception('Invalid course value: $course');
    }
  }

  AuthDetailEntity toEntity() {
    return AuthDetailEntity(
      id: id,
      fullName: fullName,
      fatherName: fatherName,
      dob: dob,
      gender: gender,
      course: course,
      courseYear: courseYear,
      email: email,
      studentPhone: studentPhone,
      parentPhone: parentPhone,
      profileImage: profileImage,
      isApproved: isApproved,
      section: section,
      role: role,
    );
  }
}

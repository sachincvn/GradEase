// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentDetail _$StudentDetailFromJson(Map<String, dynamic> json) =>
    StudentDetail(
      id: json['_id'] as String,
      fullName: json['fullName'] as String,
      fatherName: json['fatherName'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      gender: json['gender'] as String?,
      course: json['course'] as String?,
      courseYear: json['courseYear'] as int?,
      email: json['email'] as String?,
      studentPhone: json['studentPhone'] as String?,
      parentPhone: json['parentPhone'] as String?,
      profileImage: json['profileImage'] as String?,
      section: json['section'] as String?,
      isApproved: json['isApproved'] as bool?,
    );

Map<String, dynamic> _$StudentDetailToJson(StudentDetail instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'fatherName': instance.fatherName,
      'dob': instance.dob?.toIso8601String(),
      'gender': instance.gender,
      'course': instance.course,
      'courseYear': instance.courseYear,
      'email': instance.email,
      'studentPhone': instance.studentPhone,
      'parentPhone': instance.parentPhone,
      'profileImage': instance.profileImage,
      'section': instance.section,
      'isApproved': instance.isApproved,
    };

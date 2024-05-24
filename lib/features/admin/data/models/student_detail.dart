import 'package:json_annotation/json_annotation.dart';

part 'student_detail.g.dart';

@JsonSerializable()
class StudentDetail {
  @JsonKey(name: '_id')
  final String id;
  final String fullName;
  final String? fatherName;
  final DateTime? dob;
  final String? gender;
  final String? course;
  final String? role;
  final int? courseYear;
  final String? email;
  final String? studentPhone;
  final String? parentPhone;
  final String? profileImage;
  final String? section;
  final bool? isApproved;

  StudentDetail(
      {required this.id,
      required this.fullName,
      required this.fatherName,
      required this.dob,
      required this.gender,
      required this.course,
      required this.role,
      required this.courseYear,
      required this.email,
      required this.studentPhone,
      required this.parentPhone,
      required this.profileImage,
      required this.section,
      required this.isApproved});

  factory StudentDetail.fromJson(Map<String, dynamic> json) =>
      _$StudentDetailFromJson(json);

  Map<String, dynamic> toJson() => _$StudentDetailToJson(this);
}

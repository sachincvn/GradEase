import 'package:grad_ease/features/admin/data/models/student_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'students_response_model.g.dart';

@JsonSerializable()
class StudentsResponseModel {
  final int statusCode;
  final String? message;
  final List<StudentDetail>? data;

  StudentsResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory StudentsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StudentsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentsResponseModelToJson(this);
}

import 'package:grad_ease/features/assignment/data/models/assignment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assignment_response_model.g.dart';

@JsonSerializable()
class AssignmentResponseModel {
  final int statusCode;
  final String? message;
  final List<AssignmentModel>? data;

  AssignmentResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AssignmentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AssignmentResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentResponseModelToJson(this);
}

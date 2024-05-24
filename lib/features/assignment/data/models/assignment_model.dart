import 'package:grad_ease/core/common/models/author_model.dart';
import 'package:grad_ease/features/assignment/domain/entity/assignment_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assignment_model.g.dart';

@JsonSerializable()
class AssignmentModel {
  @JsonKey(name: "_id")
  final String id;
  final Author uploadedBy;
  final String title;
  final String? description;
  final String? filepath;
  final String createdDate;
  final String submittionDate;
  final String course;
  final int year;

  AssignmentModel({
    required this.uploadedBy,
    required this.id,
    required this.title,
    required this.description,
    required this.filepath,
    required this.createdDate,
    required this.submittionDate,
    required this.year,
    required this.course,
  });

  AssignmentEntity toEntity() {
    return AssignmentEntity(
      uploadedBy: uploadedBy,
      id: id,
      title: title,
      description: description,
      filepath: filepath,
      createdDate: createdDate,
      submittionDate: submittionDate,
      year: year,
      course: course,
    );
  }

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$AssignmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentModelToJson(this);
}

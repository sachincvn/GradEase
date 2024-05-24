import 'package:grad_ease/core/common/models/author_model.dart';

class AssignmentEntity {
  final String id;
  final Author uploadedBy;
  final String title;
  final String? description;
  final String filepath;
  final String createdDate;
  final String submittionDate;
  final String course;
  final int year;

  AssignmentEntity({
    required this.id,
    required this.uploadedBy,
    required this.title,
    required this.description,
    required this.filepath,
    required this.createdDate,
    required this.submittionDate,
    required this.course,
    required this.year,
  });
}

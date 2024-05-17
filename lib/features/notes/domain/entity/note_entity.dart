import 'package:grad_ease/core/common/models/author_model.dart';

class NoteEntity {
  final Author uploadedBy;
  final String id;
  final String title;
  final String? description;
  final String filepath;
  final String createdDate;
  final int year;

  NoteEntity({
    required this.uploadedBy,
    required this.id,
    required this.title,
    required this.description,
    required this.filepath,
    required this.createdDate,
    required this.year,
  });
}

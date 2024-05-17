import 'package:grad_ease/core/common/models/author_model.dart';
import 'package:grad_ease/features/notes/domain/entity/note_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

@JsonSerializable()
class NoteModel {
  @JsonKey(name: "_id")
  final String id;
  final Author uploadedBy;
  final String title;
  final String? description;
  final String filepath;
  final String createdDate;
  final int year;

  NoteModel({
    required this.uploadedBy,
    required this.id,
    required this.title,
    required this.description,
    required this.filepath,
    required this.createdDate,
    required this.year,
  });

  NoteEntity toEntity() {
    return NoteEntity(
      uploadedBy: uploadedBy,
      id: id,
      title: title,
      description: description,
      filepath: filepath,
      createdDate: createdDate,
      year: year,
    );
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}

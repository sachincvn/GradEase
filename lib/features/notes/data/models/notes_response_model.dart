import 'package:grad_ease/features/notes/data/models/note_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notes_response_model.g.dart';

@JsonSerializable()
class NotesResponseModel {
  final int statusCode;
  final String? message;
  final List<NoteModel>? data;

  NotesResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory NotesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NotesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotesResponseModelToJson(this);
}

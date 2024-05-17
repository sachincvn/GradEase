// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) => NoteModel(
      uploadedBy: Author.fromJson(json['uploadedBy'] as Map<String, dynamic>),
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      filepath: json['filepath'] as String,
      createdDate: json['createdDate'] as String,
      year: json['year'] as int,
    );

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      '_id': instance.id,
      'uploadedBy': instance.uploadedBy,
      'title': instance.title,
      'description': instance.description,
      'filepath': instance.filepath,
      'createdDate': instance.createdDate,
      'year': instance.year,
    };

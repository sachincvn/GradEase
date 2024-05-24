// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentModel _$AssignmentModelFromJson(Map<String, dynamic> json) =>
    AssignmentModel(
      uploadedBy: Author.fromJson(json['uploadedBy'] as Map<String, dynamic>),
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      filepath: json['filepath'] as String?,
      createdDate: json['createdDate'] as String,
      submittionDate: json['submittionDate'] as String,
      year: json['year'] as int,
      course: json['course'] as String,
    );

Map<String, dynamic> _$AssignmentModelToJson(AssignmentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'uploadedBy': instance.uploadedBy,
      'title': instance.title,
      'description': instance.description,
      'filepath': instance.filepath,
      'createdDate': instance.createdDate,
      'submittionDate': instance.submittionDate,
      'course': instance.course,
      'year': instance.year,
    };

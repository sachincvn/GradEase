// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_table_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableEntry _$TimetableEntryFromJson(Map<String, dynamic> json) =>
    TimetableEntry(
      subjectName: json['SubjectName'] as String,
      teacherName: json['TeacherName'] as String,
      time: json['Time'] as String,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$TimetableEntryToJson(TimetableEntry instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'SubjectName': instance.subjectName,
      'TeacherName': instance.teacherName,
      'Time': instance.time,
    };

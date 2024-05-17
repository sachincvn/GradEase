// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeTableModel _$TimeTableModelFromJson(Map<String, dynamic> json) =>
    TimeTableModel(
      id: json['_id'] as String,
      course: json['course'] as String,
      section: json['section'] as String,
      year: json['year'] as int,
      timetable: (json['timetable'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => TimetableEntry.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$TimeTableModelToJson(TimeTableModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'course': instance.course,
      'section': instance.section,
      'year': instance.year,
      'timetable': instance.timetable,
    };

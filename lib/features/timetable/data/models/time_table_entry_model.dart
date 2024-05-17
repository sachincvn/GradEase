import 'package:json_annotation/json_annotation.dart';

part 'time_table_entry_model.g.dart';

@JsonSerializable()
class TimetableEntry {
  @JsonKey(name: "_id")
  final String id;

  @JsonKey(name: "SubjectName")
  final String subjectName;

  @JsonKey(name: "TeacherName")
  final String teacherName;

  @JsonKey(name: "Time")
  final String time;

  TimetableEntry({
    required this.subjectName,
    required this.teacherName,
    required this.time,
    required this.id,
  });

  factory TimetableEntry.fromJson(Map<String, dynamic> json) =>
      _$TimetableEntryFromJson(json);

  Map<String, dynamic> toJson() => _$TimetableEntryToJson(this);
}

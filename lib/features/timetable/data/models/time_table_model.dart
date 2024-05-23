import 'package:grad_ease/features/timetable/data/models/time_table_entry_model.dart';
import 'package:grad_ease/features/timetable/domain/entity/time_table_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_table_model.g.dart';

@JsonSerializable()
class TimeTableModel {
  @JsonKey(name: "_id")
  final String? id;
  final String course;
  final String section;
  final int year;
  final Map<String, List<TimetableEntry>> timetable;

  TimeTableModel({
    required this.id,
    required this.course,
    required this.section,
    required this.year,
    required this.timetable,
  });

  factory TimeTableModel.fromJson(Map<String, dynamic> json) =>
      _$TimeTableModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeTableModelToJson(this);

  Map<String, dynamic> toPostJson() {
    final timetable = this.timetable.map(
          (k, v) => MapEntry(
            k,
            v.map((e) => e.toPostJson()).toList(),
          ),
        );

    return {
      'course': course,
      'section': section,
      'year': year,
      'timetableData': timetable,
    };
  }

  TimeTableEntity toEntity() {
    return TimeTableEntity(
      id: id ?? "",
      course: course,
      section: section,
      year: year,
      timetable: timetable,
    );
  }
}

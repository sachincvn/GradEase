import 'package:grad_ease/features/timetable/data/models/time_table_entry_model.dart';

class TimeTableEntity {
  final String id;
  final String course;
  final String section;
  final int year;
  final Map<String, List<TimetableEntry>> timetable;

  TimeTableEntity({
    required this.id,
    required this.course,
    required this.section,
    required this.year,
    required this.timetable,
  });
}

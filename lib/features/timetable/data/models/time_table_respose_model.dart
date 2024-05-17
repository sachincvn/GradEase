import 'package:grad_ease/features/timetable/data/models/time_table_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_table_respose_model.g.dart';

@JsonSerializable()
class TimeTableResponseModel {
  final int statusCode;
  final String? message;
  final TimeTableModel? data;

  TimeTableResponseModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TimeTableResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TimeTableResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeTableResponseModelToJson(this);
}

// ignore_for_file: non_constant_identifier_names

import 'package:grad_ease/features/uucms/domain/entity/exam_application_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exam_application_model.g.dart';

@JsonSerializable()
class ExamApplicationModel {
  final String? examMonth;
  final String? examType;
  final int? programLevel;
  final int? Id;
  final String? status;
  final int? enbs_id;
  final String? plName;
  final String? termName;
  final bool? IsResultPublished;
  final bool? IsRejectionAllowed;
  final int? termID;

  ExamApplicationModel({
    required this.examMonth,
    required this.examType,
    required this.programLevel,
    required this.Id,
    required this.status,
    required this.enbs_id,
    required this.plName,
    required this.termName,
    required this.IsResultPublished,
    required this.IsRejectionAllowed,
    required this.termID,
  });

  factory ExamApplicationModel.fromJson(Map<String, dynamic> json) =>
      _$ExamApplicationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamApplicationModelToJson(this);

  ExamApplicationEntity toEntity() {
    return ExamApplicationEntity(
        examMonth: examMonth,
        examType: examType,
        programLevel: programLevel,
        Id: Id,
        status: status,
        enbs_id: enbs_id,
        plName: plName,
        termName: termName,
        IsResultPublished: IsResultPublished,
        IsRejectionAllowed: IsRejectionAllowed,
        termID: termID);
  }
}

// ignore_for_file: non_constant_identifier_names

import 'package:grad_ease/features/uucms/domain/entity/exam_result_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exam_result_model.g.dart';

@JsonSerializable()
class ExamResultModel {
  final int? Slno;
  final String? CourseCode;
  final String? CourseName;
  final double? MaximumMarks;
  final double? MinimumMarks;
  final String? IAMarks;
  final String? SEMarks;
  final String? MarksScored;
  final double? Credit;
  final double? Grade;
  final double? GradePoint;
  final double? SGPA;
  final double? CGPA;
  final String? Status;
  final String? ERStatus;
  final String? LetterGrade;
  final String? TermGrade;
  final String? PromotionStatus;

  ExamResultModel({
    required this.Slno,
    required this.CourseCode,
    required this.CourseName,
    required this.MaximumMarks,
    required this.MinimumMarks,
    required this.IAMarks,
    required this.SEMarks,
    required this.MarksScored,
    required this.Credit,
    required this.Grade,
    required this.GradePoint,
    required this.SGPA,
    required this.CGPA,
    required this.Status,
    required this.ERStatus,
    required this.LetterGrade,
    required this.TermGrade,
    required this.PromotionStatus,
  });

  factory ExamResultModel.fromJson(Map<String, dynamic> json) =>
      _$ExamResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamResultModelToJson(this);

  ExamResultEntity toEntity() {
    return ExamResultEntity(
      Slno: Slno,
      CourseCode: CourseCode,
      CourseName: CourseName,
      MaximumMarks: MaximumMarks,
      MinimumMarks: MinimumMarks,
      IAMarks: IAMarks,
      SEMarks: SEMarks,
      MarksScored: MarksScored,
      Credit: Credit,
      Grade: Grade,
      GradePoint: GradePoint,
      SGPA: SGPA,
      CGPA: CGPA,
      Status: Status,
      ERStatus: ERStatus,
      LetterGrade: LetterGrade,
      PromotionStatus: PromotionStatus,
      TermGrade: TermGrade,
    );
  }
}

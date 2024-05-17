// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamResultModel _$ExamResultModelFromJson(Map<String, dynamic> json) =>
    ExamResultModel(
      Slno: json['Slno'] as int?,
      CourseCode: json['CourseCode'] as String?,
      CourseName: json['CourseName'] as String?,
      MaximumMarks: (json['MaximumMarks'] as num?)?.toDouble(),
      MinimumMarks: (json['MinimumMarks'] as num?)?.toDouble(),
      IAMarks: json['IAMarks'] as String?,
      SEMarks: json['SEMarks'] as String?,
      MarksScored: json['MarksScored'] as String?,
      Credit: (json['Credit'] as num?)?.toDouble(),
      Grade: (json['Grade'] as num?)?.toDouble(),
      GradePoint: (json['GradePoint'] as num?)?.toDouble(),
      SGPA: (json['SGPA'] as num?)?.toDouble(),
      CGPA: (json['CGPA'] as num?)?.toDouble(),
      Status: json['Status'] as String?,
      ERStatus: json['ERStatus'] as String?,
      LetterGrade: json['LetterGrade'] as String?,
      TermGrade: json['TermGrade'] as String?,
      PromotionStatus: json['PromotionStatus'] as String?,
    );

Map<String, dynamic> _$ExamResultModelToJson(ExamResultModel instance) =>
    <String, dynamic>{
      'Slno': instance.Slno,
      'CourseCode': instance.CourseCode,
      'CourseName': instance.CourseName,
      'MaximumMarks': instance.MaximumMarks,
      'MinimumMarks': instance.MinimumMarks,
      'IAMarks': instance.IAMarks,
      'SEMarks': instance.SEMarks,
      'MarksScored': instance.MarksScored,
      'Credit': instance.Credit,
      'Grade': instance.Grade,
      'GradePoint': instance.GradePoint,
      'SGPA': instance.SGPA,
      'CGPA': instance.CGPA,
      'Status': instance.Status,
      'ERStatus': instance.ERStatus,
      'LetterGrade': instance.LetterGrade,
      'TermGrade': instance.TermGrade,
      'PromotionStatus': instance.PromotionStatus,
    };

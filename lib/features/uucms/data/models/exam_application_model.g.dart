// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamApplicationModel _$ExamApplicationModelFromJson(
        Map<String, dynamic> json) =>
    ExamApplicationModel(
      examMonth: json['examMonth'] as String?,
      examType: json['examType'] as String?,
      programLevel: json['programLevel'] as int?,
      Id: json['Id'] as int?,
      status: json['status'] as String?,
      enbs_id: json['enbs_id'] as int?,
      plName: json['plName'] as String?,
      termName: json['termName'] as String?,
      IsResultPublished: json['IsResultPublished'] as bool?,
      IsRejectionAllowed: json['IsRejectionAllowed'] as bool?,
      termID: json['termID'] as int?,
    );

Map<String, dynamic> _$ExamApplicationModelToJson(
        ExamApplicationModel instance) =>
    <String, dynamic>{
      'examMonth': instance.examMonth,
      'examType': instance.examType,
      'programLevel': instance.programLevel,
      'Id': instance.Id,
      'status': instance.status,
      'enbs_id': instance.enbs_id,
      'plName': instance.plName,
      'termName': instance.termName,
      'IsResultPublished': instance.IsResultPublished,
      'IsRejectionAllowed': instance.IsRejectionAllowed,
      'termID': instance.termID,
    };

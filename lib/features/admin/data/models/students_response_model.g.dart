// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentsResponseModel _$StudentsResponseModelFromJson(
        Map<String, dynamic> json) =>
    StudentsResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => StudentDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StudentsResponseModelToJson(
        StudentsResponseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

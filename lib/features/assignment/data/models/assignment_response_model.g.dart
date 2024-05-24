// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentResponseModel _$AssignmentResponseModelFromJson(
        Map<String, dynamic> json) =>
    AssignmentResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AssignmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssignmentResponseModelToJson(
        AssignmentResponseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_table_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeTableResponseModel _$TimeTableResponseModelFromJson(
        Map<String, dynamic> json) =>
    TimeTableResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TimeTableModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimeTableResponseModelToJson(
        TimeTableResponseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

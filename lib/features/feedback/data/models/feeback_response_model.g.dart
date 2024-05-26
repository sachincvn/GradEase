// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeback_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackResponseModel _$FeedbackResponseModelFromJson(
        Map<String, dynamic> json) =>
    FeedbackResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((e) => FeedbackModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedbackResponseModelToJson(
        FeedbackResponseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

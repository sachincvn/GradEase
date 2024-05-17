// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_file_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadFileResponseModel _$UploadFileResponseModelFromJson(
        Map<String, dynamic> json) =>
    UploadFileResponseModel(
      message: json['message'] as String,
      filePath: json['filePath'] as String,
    );

Map<String, dynamic> _$UploadFileResponseModelToJson(
        UploadFileResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'filePath': instance.filePath,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotesResponseModel _$NotesResponseModelFromJson(Map<String, dynamic> json) =>
    NotesResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotesResponseModelToJson(NotesResponseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communites_reponse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityRespnseModel _$CommunityRespnseModelFromJson(
        Map<String, dynamic> json) =>
    CommunityRespnseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>)
          .map((e) => CommunityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommunityRespnseModelToJson(
        CommunityRespnseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

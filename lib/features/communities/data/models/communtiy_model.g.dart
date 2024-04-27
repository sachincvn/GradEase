// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communtiy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityModel _$CommunityModelFromJson(Map<String, dynamic> json) =>
    CommunityModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      profileImage: json['profileImage'] as String,
      course: json['course'] as String,
      year: json['year'] as int,
      members: (json['members'] as List<dynamic>)
          .map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$CommunityModelToJson(CommunityModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'profileImage': instance.profileImage,
      'course': instance.course,
      'year': instance.year,
      'members': instance.members,
      'createdAt': instance.createdAt,
    };

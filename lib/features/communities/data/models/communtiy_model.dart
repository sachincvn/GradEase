import 'package:grad_ease/core/common/models/author_model.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'communtiy_model.g.dart';

@JsonSerializable()
class CommunityModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String description;
  final String profileImage;
  final String course;
  final int year;
  final List<Author> members;
  final String createdAt;

  CommunityModel({
    required this.id,
    required this.name,
    required this.description,
    required this.profileImage,
    required this.course,
    required this.year,
    required this.members,
    required this.createdAt,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityModelToJson(this);

  CommunityEntity toEntity() {
    return CommunityEntity(
      id: id,
      name: name,
      description: description,
      profileImage: profileImage,
      course: course,
      year: year,
      members: members,
      createdAt: createdAt,
    );
  }
}

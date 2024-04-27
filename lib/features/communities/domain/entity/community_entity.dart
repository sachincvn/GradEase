import 'package:grad_ease/core/common/models/author_model.dart';

class CommunityEntity {
  final String id;
  final String name;
  final String description;
  final String profileImage;
  final String course;
  final int year;
  final List<Author> members;
  final String createdAt;

  CommunityEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.profileImage,
    required this.course,
    required this.year,
    required this.members,
    required this.createdAt,
  });
}

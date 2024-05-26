import 'package:grad_ease/core/common/models/author_model.dart';

class CommunityMessageEntity {
  final String id;
  final String communityId;
  final Author? sender;
  final String message;
  final String createdAt;

  CommunityMessageEntity({
    required this.id,
    required this.communityId,
    required this.sender,
    required this.message,
    required this.createdAt,
  });
}

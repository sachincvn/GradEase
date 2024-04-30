import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';
import 'package:grad_ease/features/communities/domain/entity/community_message_entity.dart';

abstract interface class CommunityRepository {
  Future<Either<Failure, List<CommunityEntity>>> getAllCommunties();
  Future<Either<Failure, List<CommunityMessageEntity>>> getAllCommunityMessage(
      {String? communityId, int page = 1, int pageLimt = 10});
  Future<Either<Failure, CommunityMessageEntity>> sendCommunityMessage(
      String communityId, String message);
}

import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';

abstract interface class CommunityRepository {
  Future<Either<Failure, List<CommunityEntity>>> getAllCommunties();
}

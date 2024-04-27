import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';
import 'package:grad_ease/features/communities/domain/repository/communtiy_repository.dart';

class GetCommunityUseCase implements UseCase<List<CommunityEntity>, NoParams> {
  final CommunityRepository _communityRepository;

  GetCommunityUseCase(this._communityRepository);

  @override
  Future<Either<Failure, List<CommunityEntity>>> call(NoParams params) async {
    return await _communityRepository.getAllCommunties();
  }
}

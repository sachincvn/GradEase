import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/communities/domain/entity/community_message_entity.dart';
import 'package:grad_ease/features/communities/domain/repository/communtiy_repository.dart';

class GetCommunityMessagesUseCase
    implements
        UseCase<List<CommunityMessageEntity>, GetCommunityMessagesParams> {
  final CommunityRepository _communityRepository;

  GetCommunityMessagesUseCase(this._communityRepository);

  @override
  Future<Either<Failure, List<CommunityMessageEntity>>> call(
      GetCommunityMessagesParams communityMessagesParams) async {
    return await _communityRepository.getAllCommunityMessage(
      communityId: communityMessagesParams.communityId,
      page: communityMessagesParams.page,
      pageLimt: communityMessagesParams.pageSize,
    );
  }
}

class GetCommunityMessagesParams {
  final String communityId;
  final int page;
  final int pageSize;

  GetCommunityMessagesParams(this.communityId,
      [this.page = 1, this.pageSize = 10]);
}

import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/communities/domain/entity/community_message_entity.dart';
import 'package:grad_ease/features/communities/domain/repository/communtiy_repository.dart';

class SendMessageUseCase
    implements UseCase<CommunityMessageEntity, SendMessageParams> {
  final CommunityRepository _communityRepository;
  SendMessageUseCase(this._communityRepository);
  @override
  Future<Either<Failure, CommunityMessageEntity>> call(
      SendMessageParams params) async {
    return await _communityRepository.sendCommunityMessage(
        params.communityId, params.message);
  }
}

class SendMessageParams {
  final String message;
  final String communityId;

  SendMessageParams(this.message, this.communityId);
}

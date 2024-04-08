import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/entities/author_entity.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/feeds/domain/repository/feed_post_repository.dart';

class AddReplyUseCase implements UseCase<bool, AddReplyUseCaseParams> {
  final FeedPostRepository _feedPostRepository;
  AddReplyUseCase(this._feedPostRepository);

  @override
  Future<Either<Failure, bool>> call(AddReplyUseCaseParams params) async {
    return await _feedPostRepository.addPostReply(
        params.postId, params.content);
  }

  AuthorEntity? authorEntity() => _feedPostRepository.getLocalAuthorDetail();
}

class AddReplyUseCaseParams {
  final String postId;
  final String content;

  AddReplyUseCaseParams({required this.postId, required this.content});
}

import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_reply_entity.dart';
import 'package:grad_ease/features/feeds/domain/repository/feed_post_repository.dart';

class GetRepliesUseCase implements UseCase<List<FeedPostReplyEntity>, String> {
  final FeedPostRepository _feedPostRepository;

  GetRepliesUseCase(this._feedPostRepository);

  @override
  Future<Either<Failure, List<FeedPostReplyEntity>>> call(String postId) async {
    return await _feedPostRepository.getFeedPostReplies(postId);
  }
}

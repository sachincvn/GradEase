import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:grad_ease/features/feeds/domain/repository/feed_post_repository.dart';

class DislikePostUseCase implements UseCase<FeedPostEntity, FeedPostEntity> {
  final FeedPostRepository _feedPostRepository;

  DislikePostUseCase(this._feedPostRepository);

  @override
  Future<Either<Failure, FeedPostEntity>> call(
    FeedPostEntity feedPostItem,
  ) async {
    return await _feedPostRepository.dislikePost(feedPostItem.id);
  }
}

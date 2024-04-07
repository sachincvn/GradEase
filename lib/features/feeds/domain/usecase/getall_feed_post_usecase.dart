import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:grad_ease/features/feeds/domain/repository/feed_post_repository.dart';

class GetAllFeedPostUseCase
    implements UseCase<List<FeedPostEntity?>, NoParams> {
  final FeedPostRepository feedPostRepository;

  GetAllFeedPostUseCase(this.feedPostRepository);
  @override
  Future<Either<Failure, List<FeedPostEntity?>>> call(NoParams params) async {
    return await feedPostRepository.getAllFeedPosts();
  }
}

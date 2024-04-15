import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/feeds/domain/repository/feed_post_repository.dart';

class DeletePostUseCase implements UseCase<String?, String> {
  final FeedPostRepository _feedPostRepository;
  DeletePostUseCase(this._feedPostRepository);

  @override
  Future<Either<Failure, String?>> call(String id) async {
    return await _feedPostRepository.deletePost(id);
  }
}

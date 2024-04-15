import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:grad_ease/features/feeds/domain/repository/feed_post_repository.dart';

class AddPostUseCase implements UseCase<FeedPostEntity, AddPostParams> {
  final FeedPostRepository feedPostRepository;

  AddPostUseCase(this.feedPostRepository);

  @override
  Future<Either<Failure, FeedPostEntity>> call(AddPostParams params) async {
    if (params.title.isEmpty && params.title.length < 3) {
      return left(Failure("Title must be greater !"));
    }
    if (params.description.isEmpty && params.description.length < 8) {
      return left(Failure("Description must be greater !"));
    }
    return await feedPostRepository.createNewPost(
      params.title,
      params.description,
    );
  }
}

class AddPostParams {
  final String title;
  final String description;

  AddPostParams({required this.title, required this.description});
}

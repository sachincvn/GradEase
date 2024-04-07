import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';

abstract interface class FeedPostRepository {
  Future<Either<Failure, List<FeedPostEntity?>>> getAllFeedPosts();
  Future<Either<Failure, FeedPostEntity?>> getPostById(
      String id, String userId);
  Future<Either<Failure, bool>> likePost(String id, String userId);
  Future<Either<Failure, bool>> dislikePost(String id, String userId);
  Future<Either<Failure, bool>> deletePost(String id, String userId);
}

import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/feeds/data/data_sourse/feed_post_remote_data_source.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:grad_ease/features/feeds/domain/repository/feed_post_repository.dart';

class FeedPostRepositoryImpl implements FeedPostRepository {
  final FeedPostRemoteDataSource _feedPostRemoteDataSource;

  FeedPostRepositoryImpl({
    required FeedPostRemoteDataSource feedPostRemoteDataSource,
  }) : _feedPostRemoteDataSource = feedPostRemoteDataSource;

  @override
  Future<Either<Failure, bool>> deletePost(String id, String userId) async {
    try {
      final deletePost = await _feedPostRemoteDataSource.deletePost(id, userId);
      return right(deletePost);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> dislikePost(String id, String userId) async {
    try {
      final dislikePost =
          await _feedPostRemoteDataSource.dislikePost(id, userId);
      return right(dislikePost);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FeedPostEntity?>>> getAllFeedPosts() async {
    try {
      final posts = await _feedPostRemoteDataSource.getAllFeedPosts();
      if (posts?.data != null) {
        return right(posts!.data!.map((e) => e!.toEntity()).toList());
      }
      return left(Failure("Something went wrong !"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FeedPostEntity?>> getPostById(
      String id, String userId) async {
    try {
      final post = await _feedPostRemoteDataSource.getPostById(id, userId);
      return right(post?.data?.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> likePost(String id, String userId) async {
    try {
      final likePost = await _feedPostRemoteDataSource.likePost(id, userId);
      return right(likePost);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

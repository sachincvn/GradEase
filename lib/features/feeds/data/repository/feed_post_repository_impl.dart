import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/entities/author_entity.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/feeds/data/data_sourse/feed_post_remote_data_source.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_reply_entity.dart';
import 'package:grad_ease/features/feeds/domain/repository/feed_post_repository.dart';

class FeedPostRepositoryImpl implements FeedPostRepository {
  final FeedPostRemoteDataSource _feedPostRemoteDataSource;
  final LocalDetailsRepository _localDetailsRepository;

  late final String userId;

  FeedPostRepositoryImpl(
      this._feedPostRemoteDataSource, this._localDetailsRepository) {
    userId = _localDetailsRepository.getUserId()!;
  }

  @override
  Future<Either<Failure, String?>> deletePost(String id) async {
    try {
      final deletePost = await _feedPostRemoteDataSource.deletePost(id, userId);
      return right(deletePost.data);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FeedPostEntity>> dislikePost(String id) async {
    try {
      final dislikePost =
          await _feedPostRemoteDataSource.dislikePost(id, userId);
      return right(dislikePost.data!.toEntity());
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
    String id,
  ) async {
    try {
      final post = await _feedPostRemoteDataSource.getPostById(id);
      return right(post?.data?.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FeedPostEntity>> likePost(String id) async {
    try {
      final likePost = await _feedPostRemoteDataSource.likePost(id, userId);
      return right(likePost.data!.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FeedPostReplyEntity>>> getFeedPostReplies(
    String id,
  ) async {
    try {
      final postReplies =
          await _feedPostRemoteDataSource.getFeesPostReplies(id);
      return right(postReplies.data!.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addPostReply(
    String postId,
    String content,
  ) async {
    try {
      final response =
          await _feedPostRemoteDataSource.addPostReply(postId, userId, content);
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deletePostReply(
    String postId,
    String replyId,
  ) async {
    try {
      final response =
          await _feedPostRemoteDataSource.deletePostReply(postId, replyId);
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  AuthorEntity? getLocalAuthorDetail() =>
      _localDetailsRepository.getAuthorEntity();

  @override
  Future<Either<Failure, String?>> createNewPost(
    String title,
    String description,
  ) async {
    try {
      final postId = await _feedPostRemoteDataSource.createNewPost(
          title, description, userId);
      return right(postId.data);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

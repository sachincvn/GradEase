import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/entities/author_entity.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_reply_entity.dart';

abstract interface class FeedPostRepository {
  Future<Either<Failure, List<FeedPostEntity?>>> getAllFeedPosts();
  Future<Either<Failure, FeedPostEntity?>> getPostById(
      String id, String userId);
  Future<Either<Failure, String?>> likePost(String id);
  Future<Either<Failure, String?>> dislikePost(String id);
  Future<Either<Failure, String?>> deletePost(String id);
  Future<Either<Failure, List<FeedPostReplyEntity>>> getFeedPostReplies(
    String id,
  );
  Future<Either<Failure, bool>> addPostReply(String postId, String content);
  Future<Either<Failure, bool>> deletePostReply(String postId, String replyId);
  Future<Either<Failure, String?>> createNewPost(
      String title, String description);
  AuthorEntity? getLocalAuthorDetail();
}

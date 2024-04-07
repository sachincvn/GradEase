import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/remote/gradease_rest_service.dart';
import 'package:grad_ease/features/feeds/data/models/feed_post_response.dart';
import 'package:grad_ease/features/feeds/data/models/feed_posts_response.dart';

abstract interface class FeedPostRemoteDataSource {
  Future<FeedPostsResponse?> getAllFeedPosts();
  Future<FeedPostResponse?> getPostById(String id, String userId);
  Future<bool> likePost(String id, String userId);
  Future<bool> dislikePost(String id, String userId);
  Future<bool> deletePost(String id, String userId);
}

class FeedPostRemoteDataSourceImpl extends GradEaseRestService
    implements FeedPostRemoteDataSource {
  @override
  Future<bool> deletePost(String id, String userId) async {
    final restRequest = createDeleteRequest(RestResources.deletePost(id));
    final response = await executeRequest(restRequest);
    return response.data;
  }

  @override
  Future<bool> dislikePost(String id, String userId) async {
    final restRequest = createPostRequest(RestResources.dislikePost,
        body: {"postId": id, "userId": userId});
    final response = await executeRequest(restRequest);
    return response.data;
  }

  @override
  Future<FeedPostsResponse> getAllFeedPosts() async {
    final restRequest = createGetRequest(RestResources.feedPosts);
    final response = await executeRequest(restRequest);
    return FeedPostsResponse.fromJson(response.data);
  }

  @override
  Future<FeedPostResponse?> getPostById(String id, String userId) async {
    final restRequest = createGetRequest(RestResources.getPostById(id));
    final response = await executeRequest(restRequest);
    return FeedPostResponse.fromJson(response.data);
  }

  @override
  Future<bool> likePost(String id, String userId) async {
    final restRequest = createPostRequest(RestResources.likePost,
        body: {"postId": id, "userId": userId});
    final response = await executeRequest(restRequest);
    return response.data;
  }
}

import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/remote/gradease_rest_service.dart';
import 'package:grad_ease/features/communities/data/models/communites_reponse_model.dart';
import 'package:grad_ease/features/communities/data/models/community_message_response_model.dart';
import 'package:grad_ease/features/communities/data/models/community_message_sent_response_model.dart';

abstract interface class CommunityRemoteDataSource {
  Future<CommunityRespnseModel> getCommunites(String course, int year);

  Future<CommunityMessageResponseModel> getCommunityMessages(
    String communityId,
    int page,
    int pageSize,
  );

  Future<CommunityMessageSentResponseModel> sendCommunityMessage(
    String senderId,
    String communityId,
    String message,
  );
}

class CommunityRemoteDataSourceImpl extends GradEaseRestService
    implements CommunityRemoteDataSource {
  @override
  Future<CommunityRespnseModel> getCommunites(String course, int year) async {
    final restRequest =
        createGetRequest(RestResources.getCommunites(course, year));
    final response = await executeRequest(restRequest);
    return CommunityRespnseModel.fromJson(response.data);
  }

  @override
  Future<CommunityMessageResponseModel> getCommunityMessages(
    String communityId,
    int page,
    int pageSize,
  ) async {
    final restRequest = createGetRequest(RestResources.getCommunityMessages(
      communityId,
      page: page,
      pageLimit: pageSize,
    ));
    final response = await executeRequest(restRequest);
    return CommunityMessageResponseModel.fromJson(response.data);
  }

  @override
  Future<CommunityMessageSentResponseModel> sendCommunityMessage(
      String senderId, String communityId, String message) async {
    final restRequest =
        createPostRequest(RestResources.sendCommunityMessages, body: {
      "communityId": communityId,
      "message": message,
      "senderId": senderId,
    });
    final response = await executeRequest(restRequest);
    return CommunityMessageSentResponseModel.fromJson(response.data);
  }
}

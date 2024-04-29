import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/remote/gradease_rest_service.dart';
import 'package:grad_ease/features/communities/data/models/communites_reponse_model.dart';
import 'package:grad_ease/features/communities/data/models/community_message_response_model.dart';

abstract interface class CommunityRemoteDataSource {
  Future<CommunityRespnseModel> getCommunites(String course, int year);
  Future<CommunityMessageResponseModel> getCommunityMessages(
      String communityId);
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
      String communityId) async {
    final restRequest =
        createGetRequest(RestResources.getCommunityMessages(communityId));
    final response = await executeRequest(restRequest);
    return CommunityMessageResponseModel.fromJson(response.data);
  }
}

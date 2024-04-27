import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/remote/gradease_rest_service.dart';
import 'package:grad_ease/features/communities/data/models/communites_reponse_model.dart';

abstract interface class CommunityRemoteDataSource {
  Future<CommunityRespnseModel> getCommunites(String course, int year);
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
}

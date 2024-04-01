import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/remote/gradease_rest_service.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';

abstract interface class AuthRemoteDataSource {
  Future<RestResponse<String>> studentLogin({
    required String email,
    required String password,
  });

  Future<RestResponse<String>> adminLogin({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl extends GradEaseRestService
    implements AuthRemoteDataSource {
  @override
  Future<RestResponse<String>> adminLogin(
      {required String email, required String password}) async {
    final restRequest = createPostRequest("", body: {});
    final response = await executeRequest(restRequest);
    return response.data;
  }

  @override
  Future<RestResponse<String>> studentLogin(
      {required String email, required String password}) async {
    final restRequest = createPostRequest(RestResources.studentLogin,
        body: {"email": email, "password": password});
    final response = await executeRequest(restRequest);
    return RestResponse.fromJson(response.data);
  }
}

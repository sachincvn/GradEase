import 'package:dio/dio.dart';
import 'package:grad_ease/core/extension/rest_request_extensions.dart';
import 'package:grad_ease/core/remote/rest_client.dart';
import 'package:grad_ease/core/remote/rest_service_base.dart';

class GradEaseRestService extends RestServiceBase {
  @override
  RestRequest createGetRequest(String resource, {body}) {
    final request = super.createGetRequest(resource, body: body);
    request.addAuthorizationHeader();
    return request;
  }

  @override
  RestRequest createPostRequest(String resource, {body}) {
    final request = super.createPostRequest(resource, body: body);
    request.addAuthorizationHeader();
    return request;
  }

  @override
  RestRequest createPutRequest(String resource, {body}) {
    final request = super.createPutRequest(resource, body: body);
    request.addAuthorizationHeader();
    return request;
  }

  @override
  RestRequest createDeleteRequest(String resource, {body}) {
    final request = super.createDeleteRequest(resource, body: body);
    request.addAuthorizationHeader();
    return request;
  }

  @override
  Future<Response> executeRequest(RestRequest restRequest) async {
    try {
      var response = await super.executeRequest(restRequest);
      return response;
    } catch (error) {
      rethrow;
    }
  }
}

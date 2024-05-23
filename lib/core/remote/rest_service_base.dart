import 'package:dio/dio.dart';
import 'package:grad_ease/core/remote/rest_client.dart';
import 'package:grad_ease/core/remote/rest_exception.dart';

abstract class RestServiceBase extends RestClient {
  Future<Response> executeRequest(RestRequest restRequest) async {
    try {
      if (restRequest.requestMethod == RequestMethod.get) {
        return await dio.get(restRequest.path, options: restRequest);
      } else if (restRequest.requestMethod == RequestMethod.post) {
        return await dio.post(restRequest.path,
            data: restRequest.body, options: restRequest);
      } else if (restRequest.requestMethod == RequestMethod.put) {
        return await dio.put(restRequest.path,
            data: restRequest.body, options: restRequest);
      } else if (restRequest.requestMethod == RequestMethod.delete) {
        return await dio.delete(restRequest.path,
            data: restRequest.body, options: restRequest);
      } else {
        throw Exception("Unknown Method");
      }
    } catch (error) {
      if (error is DioException) {
        throw RestResponseException(
            message: error.response?.data['message'] ?? error);
      }
      rethrow;
    }
  }

  RestRequest createGetRequest(String resource, {dynamic body}) =>
      RestRequest(resource, null, method: RequestMethod.get);

  RestRequest createPostRequest(String resource, {dynamic body}) =>
      RestRequest(resource, body, method: RequestMethod.post);

  RestRequest createPutRequest(String resource, {dynamic body}) =>
      RestRequest(resource, body, method: RequestMethod.put);

  RestRequest createDeleteRequest(String resource, {dynamic body}) =>
      RestRequest(resource, body, method: RequestMethod.delete);
}

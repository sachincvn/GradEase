import 'package:dio/dio.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';

class RestClient {
  Dio dio = Dio();

  RestClient() {
    dio.options.baseUrl = _getRestClientBaseUrl();
  }

  String _getRestClientBaseUrl() {
    return RestResources.restApiBaseUrl(true);
  }
}

class RestRequest extends Options {
  final String path;
  final dynamic body;
  RequestMethod? requestMethod = RequestMethod.get;

  RestRequest(this.path, this.body, {RequestMethod? method, dynamic}) {
    requestMethod = method;
  }

  setRequestHeaders(Map<String, dynamic>? headers) {
    super.headers = headers;
  }
}

enum RequestMethod { get, post, put, delete }

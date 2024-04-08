import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/core/remote/rest_client.dart';
import 'package:grad_ease/init_dependencies.dart';

final _localDetailsRepository = LocalDetailsRepositoryImpl(serviceLocator());

extension RestRequestExtension on RestRequest {
  Map<String, dynamic> addAuthorizationHeader() {
    return headers = {
      'Authorization': _localDetailsRepository.getLoginAuthToken() ?? ""
    };
  }
}

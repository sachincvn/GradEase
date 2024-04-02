import 'package:grad_ease/core/remote/rest_client.dart';
import 'package:grad_ease/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:grad_ease/init_dependencies.dart';

final _authLocalDataSource = AuthLocalDataSourceImpl(serviceLocator());

extension RestRequestExtension on RestRequest {
  Map<String, dynamic> addAuthorizationHeader() {
    return headers = {
      'Authorization': _authLocalDataSource.getLoginAuthToken() ?? ""
    };
  }
}

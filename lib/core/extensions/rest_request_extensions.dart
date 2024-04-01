import 'package:grad_ease/core/remote/rest_client.dart';

extension RestRequestExtension on RestRequest {
  Map<String, dynamic> addAuthorizationHeader() {
    return headers = {
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWY5OGQwZWU3ZDQ3ZTc1YmRmNzMwY2UiLCJmdWxsTmFtZSI6IkpvaG4gRG9lIiwiZW1haWwiOiJqb2huZG9lZUBleGFtcGxlLmNvbSIsImlhdCI6MTcxMTkxMDU2NiwiZXhwIjoxNzExOTUzNzY2fQ.6FPvY20L70MygUHcLfbxiLSN52KJ1ytgQSt6IAybWm8'
    };
  }
}

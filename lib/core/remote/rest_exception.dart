class RestResponseException implements Exception {
  final String? message;

  RestResponseException({required this.message});
}

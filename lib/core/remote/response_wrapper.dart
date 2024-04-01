class RestResponse<T> {
  final int statusCode;
  final String? message;
  final T? data;

  RestResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': data,
    };
  }

  factory RestResponse.fromJson(Map<String, dynamic> json,
      {T Function(dynamic)? fromJson}) {
    return RestResponse(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? "",
      data: json['data'] != null && fromJson != null
          ? fromJson(json['data'])
          : json['data'] as T?,
    );
  }
}

class Failure {
  final String? message;

  Failure([this.message = "Something Went Wrong !"]);
}

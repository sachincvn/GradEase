class RestResources {
  static const String restApiBaseUrl = "http://192.168.0.105:8080/api/v1/";

  static const String studentLogin = "/auth/student";
  static const String adminLogin = "auth/admin";
  static String getStudentDetail(String email) => "student/$email";
}

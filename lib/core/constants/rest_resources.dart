class RestResources {
  static String restApiBaseUrl(value) => value
      ? "https://gradease.onrender.com/api/v1/"
      : "http://192.168.0.105:8080/api/v1/";

  static const String studentLogin = "/auth/student";
  static const String adminLogin = "auth/admin";
  static String getStudentDetail(String email) => "student/$email";

// Feed Post API path api/v1/post
  static const String feedPosts = "/post";
  static const String likePost = "$feedPosts/like";
  static const String dislikePost = "$feedPosts/dislike";
  static String deletePost(String id) => "/$id";
  static String getPostById(String id) => "/$id";
}

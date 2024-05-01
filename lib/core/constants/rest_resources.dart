class RestResources {
  static String hostelAddress = "http://192.168.0.40:8080/";
  static String roomAddress = "http://192.168.0.105:8080/";
  static String baseUrl = hostelAddress;
  static String restApiBaseUrl(value) =>
      value ? "https://gradease.onrender.com/api/v1/" : "$baseUrl/api/v1/";
  static const String studentLogin = "/auth/student";
  static const String adminLogin = "auth/admin";
  static String getStudentDetail(String email) => "student/$email";

// Feed Post API path api/v1/post
  static const String feedPosts = "/post";
  static const String likePost = "$feedPosts/like";
  static const String dislikePost = "$feedPosts/dislike";
  static String deletePost(String id) => "$feedPosts/$id";
  static String getPostById(String id) => "$feedPosts/$id";
  static String getPostReplies(String id) => "$feedPosts/$id/replies";
  static String addReply(String id) => "$feedPosts/$id/replies";
  static String deleteReply(String postId, String replyId) =>
      "$feedPosts/$postId/replies/$replyId";

  //communites
  static const String communites = "/communites";
  static String getCommunites(String course, int year) =>
      "$communites/$course/$year";

  static String getCommunityMessages(String communityId,
          {int page = 1, int pageLimit = 10}) =>
      "$communites/$communityId/messages?page=$page&pageSize=$pageLimit";
  static const String sendCommunityMessages = "$communites/send-message";
}

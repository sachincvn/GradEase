class RestResources {
  static String hostelAddress = "http://192.168.0.32:8080";
  static String roomAddress = "http://192.168.33.199:8080";
  static String oneplusAdress = "http://192.168.148.242:8080";
  static String baseUrl = roomAddress;
  static String imageBaseUrl = "$baseUrl/upload";
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

  static const String getAllCommunites = "$communites/getAllCommunites";
  static const String uploadCommunityImage = "$communites/uploadImage";

  static String getCommunityMessages(String communityId,
          {int page = 1, int pageLimit = 10}) =>
      "$communites/$communityId/messages?page=$page&pageSize=$pageLimit";
  static const String sendCommunityMessages = "$communites/send-message";

  //notes
  static const String notes = "/notes";
  static const String uploadNote = "$notes/upload";

  //timetable http://localhost:8080/api/v1/timetable/MCA/1/A
  static const String timetable = "/timetable";
  static String getTimeTable(String course, int year, String section) =>
      "$timetable/$course/$year/$section";

  static const String uucmsBaseUrl = "https://uucms.karnataka.gov.in/";

  //http://localhost:8080/api/v1/student/getAllStudents
  static const String students = "student";
  static const String getAllStudents = "$students/getAllStudents";
  static String studentByEmail(String studentEmail) =>
      "$students/$studentEmail";
}

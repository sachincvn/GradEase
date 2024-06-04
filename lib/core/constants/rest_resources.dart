class RestResources {
  static String gradeEaseBaseUrl = "https://gradease.onrender.com";
  static String localAddress = "http://192.168.0.108:8080";
  static String ngRockUrl =
      "https://661a-2406-7400-98-76e2-a4b0-1dec-b134-5e7e.ngrok-free.app";
  static String baseUrl = localAddress;
  static String fileBaseUrl = "$baseUrl/upload";
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
  static String communityById(String id) => "$communites/$id";

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
  static const String uploadStudentProfile = "$students/uploadProfile";
  static const String studentRegister = "$students/register";

  //assignments http://localhost:8080/api/v1/assignment/Mba/1
  static const String assignment = "assignment";
  static String getAssingmentByCourseYear(String course, int year) =>
      "$assignment/$course/$year";
  static String getAssingmentById(String id) => "$assignment/$id";

  static const String feedback = "feedback";
}

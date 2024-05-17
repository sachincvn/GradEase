import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/remote/gradease_rest_service.dart';
import 'package:grad_ease/features/uucms/data/models/exam_application_model.dart';
import 'package:grad_ease/features/uucms/data/models/exam_result_model.dart';

abstract interface class UUCMSRemoteDataSource {
  Future<bool> verifyIsLoggedIn(String cookie);
  Future<List<ExamApplicationModel>> getExamApplication(
      String? termId, String? enbsid, String uucmsCookie);
  Future<List<ExamResultModel>> getExamResult(
      String? termId, String? enbsid, String uucmsCookie);
}

class UUCMSRemoteDataSourceImpl extends GradEaseRestService
    implements UUCMSRemoteDataSource {
  UUCMSRemoteDataSourceImpl() {
    dio.options.baseUrl = RestResources.uucmsBaseUrl;
  }
  @override
  Future<bool> verifyIsLoggedIn(String cookie) async {
    final restRequest =
        createGetRequest("CourseRegistrationByStudent/StudentCourses");
    restRequest.headers = {
      "Cookie": cookie,
    };
    final response = await executeRequest(restRequest);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Future<List<ExamApplicationModel>> getExamApplication(
      String? termId, String? enbsid, String uucmsCookie) async {
    final restRequest = createPostRequest(
        "ExamGeneral/GetExamApplications?SessionSarID=undefined");
    restRequest.headers = {
      "Cookie": uucmsCookie,
    };
    final response = await executeRequest(restRequest);

    final data = (response.data as List<dynamic>?)
        ?.map((e) => ExamApplicationModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return data!;
  }

  @override
  Future<List<ExamResultModel>> getExamResult(
      String? termId, String? enbsid, String uucmsCookie) async {
    final restRequest = createGetRequest(
        "ExamReEvaluation/StudentTermExamResult?termId=$termId&enbsid=$enbsid");
    restRequest.headers = {
      "Cookie": uucmsCookie,
    };
    final response = await executeRequest(restRequest);
    final data = (response.data as List<dynamic>?)
        ?.map((e) => ExamResultModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return data!;
  }
}

import 'package:dio/dio.dart';
import 'package:grad_ease/core/common/models/upload_file_response_model.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/remote/gradease_rest_service.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/auth/data/models/student_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<RestResponse<String>> studentLogin({
    required String email,
    required String password,
  });

  Future<RestResponse<String>> adminLogin({
    required String email,
    required String password,
  });

  Future<StudentModel?> getStudentDetail(String email);
  Future<StudentModel> registerStudent(
    String fullName,
    String fatherName,
    DateTime dob,
    String gender,
    String course,
    String email,
    String studentPhone,
    String parentPhone,
    String password,
    String profileImage,
  );
  Future<UploadFileResponseModel> uploadImage(String fileName, String filePath);
}

class AuthRemoteDataSourceImpl extends GradEaseRestService
    implements AuthRemoteDataSource {
  @override
  Future<RestResponse<String>> adminLogin(
      {required String email, required String password}) async {
    final restRequest = createPostRequest(RestResources.adminLogin,
        body: {"email": email, "password": password});
    final response = await executeRequest(restRequest);
    return RestResponse.fromJson(response.data);
  }

  @override
  Future<RestResponse<String>> studentLogin(
      {required String email, required String password}) async {
    final restRequest = createPostRequest(RestResources.studentLogin,
        body: {"email": email, "password": password});
    final response = await executeRequest(restRequest);
    return RestResponse.fromJson(response.data);
  }

  @override
  Future<StudentModel?> getStudentDetail(String email) async {
    final restRequest = createGetRequest(RestResources.getStudentDetail(email));
    final response = await executeRequest(restRequest);
    return RestResponse<StudentModel>.fromJson(
      response.data,
      fromJson: (data) => StudentModel.fromMap(data),
    ).data;
  }

  @override
  Future<StudentModel> registerStudent(
    String fullName,
    String fatherName,
    DateTime dob,
    String gender,
    String course,
    String email,
    String studentPhone,
    String parentPhone,
    String password,
    String profileImage,
  ) async {
    final restRequest = createPostRequest(RestResources.studentRegister, body: {
      "fullName": fullName,
      "fatherName": fatherName,
      "dob": dob.toIso8601String(),
      "gender": gender,
      "course": course,
      "courseYear": 1,
      "email": email,
      "studentPhone": studentPhone,
      "parentPhone": parentPhone,
      "password": password,
      "profileImage": profileImage,
    });
    final response = await executeRequest(restRequest);
    return StudentModel.fromMap(response.data['data']);
  }

  @override
  Future<UploadFileResponseModel> uploadImage(
      String fileName, String filePath) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      ),
    });
    final restRequest =
        createPostRequest(RestResources.uploadStudentProfile, body: formData);
    final response = await executeRequest(restRequest);
    return UploadFileResponseModel.fromJson(response.data);
  }
}

import 'package:dio/dio.dart';
import 'package:grad_ease/core/common/models/upload_file_response_model.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/remote/gradease_rest_service.dart';
import 'package:grad_ease/features/auth/data/models/student_model.dart';

abstract interface class ProfileRemoteDataSource {
  Future<AuthLoginDetailModel> updateStudentData(
    String fullName,
    String fatherName,
    DateTime dob,
    String gender,
    String course,
    int year,
    String section,
    String email,
    String studentPhone,
    String parentPhone,
    String profileImage,
  );
  Future<UploadFileResponseModel> uploadImage(String fileName, String filePath);
}

class ProfileRemoteDataSourceImpl extends GradEaseRestService
    implements ProfileRemoteDataSource {
  @override
  Future<AuthLoginDetailModel> updateStudentData(
    String fullName,
    String fatherName,
    DateTime dob,
    String gender,
    String course,
    int year,
    String section,
    String email,
    String studentPhone,
    String parentPhone,
    String profileImage,
  ) async {
    final restRequest =
        createPutRequest(RestResources.studentByEmail(email), body: {
      "fullName": fullName,
      "fatherName": fatherName,
      "dob": dob.toIso8601String(),
      "gender": gender,
      "course": course,
      "courseYear": year,
      "email": email,
      "studentPhone": studentPhone,
      "parentPhone": parentPhone,
      "profileImage": profileImage,
      "section": section,
    });
    final response = await executeRequest(restRequest);
    return AuthLoginDetailModel.fromMap(response.data['data']);
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

import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/entities/student_enity.dart';
import 'package:grad_ease/core/common/models/upload_file_response_model.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, RestResponse<String>>> studentLogin({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> adminLogin({
    required String email,
    required String password,
  });

  Future<Either<Failure, StudentEntity?>> getStudentDetail(String email);
  Future<Either<Failure, StudentEntity?>> registerStudent(
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

  Future<UploadFileResponseModel?> uploadStudentProfile(
      String fileName, String filePath);
}

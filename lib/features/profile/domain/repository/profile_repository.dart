import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/entities/auth_detail_enity.dart';
import 'package:grad_ease/core/common/models/upload_file_response_model.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, AuthDetailEntity?>> updateStudentData(
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
  Future<UploadFileResponseModel?> uploadStudentProfile(
      String fileName, String filePath);
}

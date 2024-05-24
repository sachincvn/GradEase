import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/entities/student_enity.dart';
import 'package:grad_ease/core/common/models/upload_file_response_model.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/core/remote/rest_exception.dart';
import 'package:grad_ease/features/profile/data/data_source/profile_remote_repository.dart';
import 'package:grad_ease/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryIml implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  final LocalDetailsRepository _localDetailsRepository;
  ProfileRepositoryIml(
      this._profileRemoteDataSource, this._localDetailsRepository);

  @override
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
      String profileImage) async {
    try {
      final response = await _profileRemoteDataSource.updateStudentData(
        fullName,
        fatherName,
        dob,
        gender,
        course,
        year,
        section,
        email,
        studentPhone,
        parentPhone,
        profileImage,
      );
      _localDetailsRepository.updateStudentDetails(response);
      return right(response.toEntity());
    } on RestResponseException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<UploadFileResponseModel> uploadStudentProfile(
      String fileName, String filePath) async {
    try {
      return await _profileRemoteDataSource.uploadImage(fileName, filePath);
    } catch (e) {
      rethrow;
    }
  }
}

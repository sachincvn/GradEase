import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/entities/auth_detail_enity.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/auth/domain/repository/auth_repository.dart';

class RegisterStudentUseCase
    implements UseCase<AuthDetailEntity?, RegisterStudentParams> {
  final AuthRepository authRepository;

  RegisterStudentUseCase(this.authRepository);
  @override
  Future<Either<Failure, AuthDetailEntity?>> call(
      RegisterStudentParams params) async {
    try {
      final uploadStudentImage = await authRepository.uploadStudentProfile(
          params.profileImage, params.profileImage);
      if (uploadStudentImage != null &&
          uploadStudentImage.filePath.isNotEmpty) {
        return await authRepository.registerStudent(
          params.fullName,
          params.fatherName,
          params.dob,
          params.gender,
          params.course,
          params.email,
          params.studentPhone,
          params.parentPhone,
          params.password,
          uploadStudentImage.filePath,
        );
      } else {
        return left(Failure("Unable to register"));
      }
    } catch (e) {
      return left(Failure("Somthing Went wrong"));
    }
  }
}

final class RegisterStudentParams {
  final String fullName;
  final String fatherName;
  final DateTime dob;
  final String gender;
  final String course;
  final String email;
  final String studentPhone;
  final String parentPhone;
  final String password;
  final String profileImage;

  RegisterStudentParams({
    required this.fullName,
    required this.fatherName,
    required this.dob,
    required this.gender,
    required this.course,
    required this.email,
    required this.studentPhone,
    required this.parentPhone,
    required this.password,
    required this.profileImage,
  });
}

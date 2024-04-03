import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/entities/auth_login_entity.dart';
import 'package:grad_ease/core/common/entities/student_enity.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/auth/domain/repository/auth_repository.dart';

class StudentLoginUseCase
    implements UseCase<StudentEntity?, StudentLoginParams> {
  final AuthRepository authRepository;
  const StudentLoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, StudentEntity?>> call(
      StudentLoginParams params) async {
    try {
      final result = await authRepository.studentLogin(
        email: params.email,
        password: params.password,
      );

      if (result.isRight()) {
        final studentDetail =
            await authRepository.getStudentDetail(params.email);
        return studentDetail;
      } else {
        result.getLeft().match(
            () => throw Exception("Unexpected error occurred!"),
            (failure) => throw Exception(failure.message));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String? loginAuthToken() => authRepository.getLocalLoginAuthToken();
  AuthLoginEntity? loginDetail() => authRepository.getLocalAuthLoginDetail();
  StudentEntity? studentDetail() => authRepository.getLocalStudentDetail();
}

class StudentLoginParams {
  final String email;
  final String password;

  StudentLoginParams({required this.email, required this.password});
}

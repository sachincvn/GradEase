import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/auth/domain/repository/auth_repository.dart';

class StudentLoginUseCase
    implements UseCase<RestResponse<String>, StudentLoginParams> {
  final AuthRepository authRepository;

  const StudentLoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, RestResponse<String>>> call(
      StudentLoginParams params) async {
    return await authRepository.studentLogin(
        email: params.email, password: params.password);
  }
}

class StudentLoginParams {
  final String email;
  final String password;

  StudentLoginParams({required this.email, required this.password});
}

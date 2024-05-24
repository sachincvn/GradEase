import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/entities/auth_login_entity.dart';
import 'package:grad_ease/core/common/entities/auth_detail_enity.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/core/remote/rest_exception.dart';
import 'package:grad_ease/features/auth/domain/repository/auth_repository.dart';

class StudentLoginUseCase implements UseCase<AuthDetailEntity?, LoginParams> {
  final AuthRepository authRepository;
  final LocalDetailsRepository localDetailsRepository;
  const StudentLoginUseCase(this.authRepository, this.localDetailsRepository);

  @override
  Future<Either<Failure, AuthDetailEntity?>> call(LoginParams params) async {
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
            (failure) => throw RestResponseException(message: failure.message));
      }
    } on RestResponseException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String? loginAuthToken() => localDetailsRepository.getLoginAuthToken();
  AuthLoginEntity? loginDetail() => localDetailsRepository.getLoginDetail();
  AuthDetailEntity? studentDetail() =>
      localDetailsRepository.getStudentDetail();
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

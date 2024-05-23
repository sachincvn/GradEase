import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/auth/domain/repository/auth_repository.dart';
import 'package:grad_ease/features/auth/domain/usecase/student_login_usecase.dart';

class AdminLoginUseCase implements UseCase<String, LoginParams> {
  final AuthRepository authRepository;
  final LocalDetailsRepository localDetailsRepository;

  AdminLoginUseCase(this.authRepository, this.localDetailsRepository);
  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    return await authRepository.adminLogin(
        email: params.email, password: params.password);
  }

  void updateLocalAdminLogin() => localDetailsRepository.updateAdminLogin(true);
  bool? isAdminLogedIn() => localDetailsRepository.isAdminLogin();
  String? adminAuthToken() => localDetailsRepository.getLoginAuthToken();
}

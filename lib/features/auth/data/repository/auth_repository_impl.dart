import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:grad_ease/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  const AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, RestResponse<String>>> adminLogin(
      {required String email, required String password}) async {
    try {
      final response = await authRemoteDataSource.adminLogin(
          email: email, password: password);
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestResponse<String>>> studentLogin(
      {required String email, required String password}) async {
    try {
      final response = await authRemoteDataSource.studentLogin(
          email: email, password: password);
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

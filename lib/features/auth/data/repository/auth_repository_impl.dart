// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/entities/student_enity.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:grad_ease/features/auth/data/models/auth_login_model.dart';
import 'package:grad_ease/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final LocalDetailsRepository authLocalDataSource;

  const AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, RestResponse<String>>> adminLogin(
      {required String email, required String password}) async {
    try {
      final response = await authRemoteDataSource.adminLogin(
          email: email, password: password);
      authLocalDataSource.updateLoginDetail(
        AuthLoginModel(email: email, password: password),
        response.data!,
      );
      return right(response);
    } catch (e) {
      authLocalDataSource.clearLoginCredientials();
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestResponse<String>>> studentLogin(
      {required String email, required String password}) async {
    try {
      final response = await authRemoteDataSource.studentLogin(
        email: email,
        password: password,
      );
      if (response.data != null) {
        authLocalDataSource.updateLoginDetail(
          AuthLoginModel(email: email, password: password),
          response.data!,
        );
        return right(response);
      }
      return left(Failure("Error while logging in!"));
    } catch (e) {
      authLocalDataSource.clearLoginCredientials();
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StudentEntity?>> getStudentDetail(String email) async {
    try {
      final studentEntity = await authRemoteDataSource.getStudentDetail(email);
      if (studentEntity != null) {
        authLocalDataSource.updateStudentDetails(studentEntity);
      }
      return right(studentEntity!.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

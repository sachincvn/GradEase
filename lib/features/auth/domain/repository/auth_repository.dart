import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/entities/auth_login_entity.dart';
import 'package:grad_ease/core/common/entities/student_enity.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, RestResponse<String>>> studentLogin({
    required String email,
    required String password,
  });

  Future<Either<Failure, RestResponse<String>>> adminLogin({
    required String email,
    required String password,
  });

  Future<Either<Failure, StudentEntity?>> getStudentDetail(String email);

  AuthLoginEntity? getLocalAuthLoginDetail();
  StudentEntity? getLocalStudentDetail();
  String? getLocalLoginAuthToken();
}

import 'package:fpdart/fpdart.dart';
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
}

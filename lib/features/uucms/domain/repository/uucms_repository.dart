import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/uucms/domain/entity/exam_application_entity.dart';
import 'package:grad_ease/features/uucms/domain/entity/exam_result_model.dart';

abstract interface class UUCMSRepository {
  Future<bool> verifyIsLoggedIn();
  Future<Either<Failure, List<ExamApplicationEntity>>> getExamApplication({
    String? termId,
    String? enbsid,
  });

  Future<Either<Failure, List<ExamResultEntity>>> getExamResult({
    String? termId,
    String? enbsid,
  });
}

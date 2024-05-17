import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/uucms/data/data_sourse/uccm_remote_data_source.dart';
import 'package:grad_ease/features/uucms/domain/entity/exam_application_entity.dart';
import 'package:grad_ease/features/uucms/domain/entity/exam_result_model.dart';
import 'package:grad_ease/features/uucms/domain/repository/uucms_repository.dart';

class UUCMSRepositoryImpl implements UUCMSRepository {
  final UUCMSRemoteDataSource uucmsRemoteDataSourse;
  final LocalDetailsRepository localDetailsRepository;
  UUCMSRepositoryImpl(this.uucmsRemoteDataSourse, this.localDetailsRepository);
  @override
  Future<bool> verifyIsLoggedIn() async {
    try {
      if (localDetailsRepository.getUUCMSLoginCookie() == null) {
        return false;
      }
      return await uucmsRemoteDataSourse
          .verifyIsLoggedIn(localDetailsRepository.getUUCMSLoginCookie()!);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, List<ExamApplicationEntity>>> getExamApplication(
      {String? termId, String? enbsid}) async {
    try {
      final response = await uucmsRemoteDataSourse.getExamApplication(
          termId, enbsid, localDetailsRepository.getUUCMSLoginCookie()!);
      return right(response.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ExamResultEntity>>> getExamResult(
      {String? termId, String? enbsid}) async {
    try {
      final response = await uucmsRemoteDataSourse.getExamResult(
          termId, enbsid, localDetailsRepository.getUUCMSLoginCookie()!);
      return right(response.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

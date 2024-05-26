import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/feedback/data/data_source/feedback_remote_datasourse.dart';
import 'package:grad_ease/features/feedback/domain/entity/feedback_entity.dart';
import 'package:grad_ease/features/feedback/domain/repository/feedback_repository.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final LocalDetailsRepository _localDetailsRepository;
  final FeedbackRemoteDataSourse _feedbackRemoteDataSourse;
  FeedbackRepositoryImpl(
      this._localDetailsRepository, this._feedbackRemoteDataSourse);

  @override
  Future<Either<Failure, FeedbackEntity?>> sendFeedback(String message) async {
    try {
      final response = await _feedbackRemoteDataSourse.createFeedback(
          _localDetailsRepository.getStudentDetail()!.fullName,
          _localDetailsRepository.getStudentDetail()!.email!,
          message);
      return right(response.toEntity());
    } catch (e) {
      return left(Failure.handleException(e));
    }
  }
}

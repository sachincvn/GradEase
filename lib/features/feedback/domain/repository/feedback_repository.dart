import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/feedback/domain/entity/feedback_entity.dart';

abstract interface class FeedbackRepository {
  Future<Either<Failure, FeedbackEntity?>> sendFeedback(String message);
  Future<Either<Failure, List<FeedbackEntity?>>> getAllFeedbacks();
}

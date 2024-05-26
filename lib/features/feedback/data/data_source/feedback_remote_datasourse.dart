import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/remote/gradease_rest_service.dart';
import 'package:grad_ease/features/feedback/data/models/feedback_model.dart';

abstract interface class FeedbackRemoteDataSourse {
  Future<FeedbackModel> createFeedback(
      String name, String email, String message);
}

class FeedbackRemoteDataSourceImpl extends GradEaseRestService
    implements FeedbackRemoteDataSourse {
  @override
  Future<FeedbackModel> createFeedback(
      String name, String email, String message) async {
    final restRequest = createPostRequest(RestResources.feedback, body: {
      "name": name,
      "email": email,
      "message": message,
    });
    final response = await executeRequest(restRequest);
    return FeedbackModel.fromJson(response.data['data']);
  }
}

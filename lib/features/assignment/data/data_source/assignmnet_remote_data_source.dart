import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/remote/gradease_rest_service.dart';
import 'package:grad_ease/features/assignment/data/models/assignment_response_model.dart';

abstract interface class AssignmentRemoteDataSource {
  Future<AssignmentResponseModel> getAssignment(String course, int year);
}

class AssignmentRemoteDataSourceImpl extends GradEaseRestService
    implements AssignmentRemoteDataSource {
  @override
  Future<AssignmentResponseModel> getAssignment(String course, int year) async {
    final restRequest =
        createGetRequest(RestResources.getAssingmentByCourseYear(course, year));
    final response = await executeRequest(restRequest);
    return AssignmentResponseModel.fromJson(response.data);
  }
}

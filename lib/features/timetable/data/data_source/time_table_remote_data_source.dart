import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/remote/gradease_rest_service.dart';
import 'package:grad_ease/features/timetable/data/models/time_table_respose_model.dart';

abstract interface class TimeTableRemoteDataSource {
  Future<TimeTableResponseModel> getTimeTable(
    String course,
    int year,
    String section,
  );
}

class TimeTableRemoteDataSourceImpl extends GradEaseRestService
    implements TimeTableRemoteDataSource {
  @override
  Future<TimeTableResponseModel> getTimeTable(
      String course, int year, String section) async {
    final restRequest =
        createGetRequest(RestResources.getTimeTable(course, year, section));
    final notes = await executeRequest(restRequest);
    return TimeTableResponseModel.fromJson(notes.data);
  }
}

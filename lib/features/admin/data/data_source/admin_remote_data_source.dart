import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/remote/gradease_rest_service.dart';
import 'package:grad_ease/features/admin/data/models/student_detail.dart';
import 'package:grad_ease/features/admin/data/models/students_response_model.dart';
import 'package:grad_ease/features/admin/data/models/time_table_response_model.dart';
import 'package:grad_ease/features/timetable/data/models/time_table_respose_model.dart'
    as tt;
import 'package:grad_ease/features/timetable/data/models/time_table_model.dart'
    as ttdto;

abstract interface class AdminRemoteDataSource {
  Future<StudentsResponseModel> getAllStudents();
  Future<StudentDetail> approveStudent(String studentEmail);
  Future<StudentDetail> deleteStudent(String studentEmail);
  Future<TimeTableResponseModel> getAllTimeTables();
  Future<tt.TimeTableResponseModel> addTimeTable(
      ttdto.TimeTableModel timeTable);
  Future<tt.TimeTableResponseModel> updateTimeTable(
      ttdto.TimeTableModel timeTable);
  Future<tt.TimeTableResponseModel> deleteTimeTable(
      ttdto.TimeTableModel timeTable);
}

class AdminRemoteDataSourceImpl extends GradEaseRestService
    implements AdminRemoteDataSource {
  @override
  Future<StudentsResponseModel> getAllStudents() async {
    final restRequest = createGetRequest(RestResources.getAllStudents);
    final response = await executeRequest(restRequest);
    return StudentsResponseModel.fromJson(response.data);
  }

  @override
  Future<StudentDetail> approveStudent(String studentEmail) async {
    final restRequest =
        createPutRequest(RestResources.studentByEmail(studentEmail), body: {
      "isApproved": true,
    });
    final response = await executeRequest(restRequest);
    return StudentDetail.fromJson(response.data['data']);
  }

  @override
  Future<StudentDetail> deleteStudent(String studentEmail) async {
    final restRequest =
        createDeleteRequest(RestResources.studentByEmail(studentEmail));
    final response = await executeRequest(restRequest);
    return StudentDetail.fromJson(response.data['data']);
  }

  @override
  Future<TimeTableResponseModel> getAllTimeTables() async {
    final restRequest = createGetRequest(RestResources.timetable);
    final response = await executeRequest(restRequest);
    return TimeTableResponseModel.fromJson(response.data);
  }

  @override
  Future<tt.TimeTableResponseModel> addTimeTable(
      ttdto.TimeTableModel timeTable) async {
    final restRequest = createPostRequest(RestResources.timetable,
        body: timeTable.toPostJson());
    final response = await executeRequest(restRequest);
    return tt.TimeTableResponseModel.fromJson(response.data);
  }

  @override
  Future<tt.TimeTableResponseModel> deleteTimeTable(
      ttdto.TimeTableModel timeTable) async {
    final restRequest = createDeleteRequest(RestResources.getTimeTable(
      timeTable.course,
      timeTable.year,
      timeTable.section,
    ));
    final response = await executeRequest(restRequest);
    return tt.TimeTableResponseModel.fromJson(response.data);
  }

  @override
  Future<tt.TimeTableResponseModel> updateTimeTable(
      ttdto.TimeTableModel timeTable) async {
    final restRequest = createPutRequest(
        RestResources.getTimeTable(
          timeTable.course,
          timeTable.year,
          timeTable.section,
        ),
        body: timeTable.toPostJson());
    final response = await executeRequest(restRequest);
    return tt.TimeTableResponseModel.fromJson(response.data);
  }
}

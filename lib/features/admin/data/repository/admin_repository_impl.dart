import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/entities/auth_detail_enity.dart';
import 'package:grad_ease/core/common/models/upload_file_response_model.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/admin/data/data_source/admin_remote_data_source.dart';
import 'package:grad_ease/features/admin/data/models/student_detail.dart';
import 'package:grad_ease/features/admin/domain/repository/admin_repository.dart';
import 'package:grad_ease/features/assignment/domain/entity/assignment_entity.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';
import 'package:grad_ease/features/timetable/data/models/time_table_model.dart';
import 'package:grad_ease/features/timetable/domain/entity/time_table_entity.dart';

class AdminRepositoryIml implements AdminRepository {
  final AdminRemoteDataSource adminRemoteDataSource;
  final LocalDetailsRepository localDetailsRepository;

  AdminRepositoryIml(this.adminRemoteDataSource, this.localDetailsRepository);

  @override
  Future<Either<Failure, List<StudentDetail>>> getAllStudents() async {
    try {
      final students = await adminRemoteDataSource.getAllStudents();
      return right(students.data!);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StudentDetail>> approveStudents(
      String studentEmail) async {
    try {
      final updatedDetail =
          await adminRemoteDataSource.approveStudent(studentEmail);
      return right(updatedDetail);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StudentDetail>> deleteStudents(
      String studentEmail) async {
    try {
      final response = await adminRemoteDataSource.deleteStudent(studentEmail);
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TimeTableModel>>> getAllTimeTable() async {
    try {
      final timeTables = await adminRemoteDataSource.getAllTimeTables();
      return right(timeTables.data!);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TimeTableEntity>> addTimeTable(
      TimeTableModel timeTable) async {
    try {
      final timeTableResponse =
          await adminRemoteDataSource.addTimeTable(timeTable);
      return right(timeTableResponse.data!.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TimeTableEntity>> updateTimeTable(
      TimeTableModel timeTable) async {
    try {
      final timeTableResponse =
          await adminRemoteDataSource.updateTimeTable(timeTable);
      return right(timeTableResponse.data!.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TimeTableEntity>> deleteTimeTable(
      TimeTableModel timeTable) async {
    try {
      final timeTableResponse =
          await adminRemoteDataSource.deleteTimeTable(timeTable);
      return right(timeTableResponse.data!.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommunityEntity>>> getAllCommunties() async {
    try {
      final response = await adminRemoteDataSource.getCommunites();
      return right(response.data.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UploadFileResponseModel>> uploadCommunityImage(
      String fileName, String filePath) async {
    try {
      final response =
          await adminRemoteDataSource.uploadImage(fileName, filePath);
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommunityEntity>> addCommunity(
      String communityName,
      String communityDescription,
      String profilePath,
      int year,
      String course) async {
    try {
      final response = await adminRemoteDataSource.addCommunity(
          communityName, communityDescription, profilePath, year, course);
      return right(response.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommunityEntity>> updateCommunity(
      String id,
      String communityName,
      String communityDescription,
      String profilePath,
      int year,
      String course) async {
    try {
      final response = await adminRemoteDataSource.updateCommunity(
          id, communityName, communityDescription, profilePath, year, course);
      return right(response.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommunityEntity>> deleteCommunity(String id) async {
    try {
      final response = await adminRemoteDataSource.deleteCommunity(id);
      return right(response.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthDetailEntity>> updateStudentData(
      String fullName,
      String fatherName,
      DateTime dob,
      String gender,
      String course,
      int year,
      String section,
      String email,
      String studentPhone,
      String parentPhone,
      String profileImage,
      String role) async {
    try {
      final response = await adminRemoteDataSource.updateStudentData(
          fullName,
          fatherName,
          dob,
          gender,
          course,
          year,
          section,
          email,
          studentPhone,
          parentPhone,
          profileImage,
          role);
      return right(response.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AssignmentEntity>>> getAllAssignments() async {
    try {
      final response = await adminRemoteDataSource.getAllAssignment();
      return right(response.data!.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AssignmentEntity>> deleteAssignment(String id) async {
    try {
      final response = await adminRemoteDataSource.deleteAssignment(id);
      return right(response.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AssignmentEntity>> addAssignment(
    String title,
    String description,
    String submissionDate,
    int year,
    String course,
  ) async {
    try {
      final userDetail = localDetailsRepository.getStudentDetail()!;
      final response = await adminRemoteDataSource.addAssignment(
          title,
          description,
          submissionDate,
          year,
          course,
          userDetail.fullName,
          userDetail.email!);
      return right(response.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AssignmentEntity>> updateAssignment(
      String assignmentId,
      String title,
      String description,
      String submissionDate,
      int year,
      String course) async {
    try {
      final userDetail = localDetailsRepository.getStudentDetail()!;
      final response = await adminRemoteDataSource.updateAssignment(
          assignmentId,
          title,
          description,
          submissionDate,
          year,
          course,
          userDetail.fullName,
          userDetail.email!);
      return right(response.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

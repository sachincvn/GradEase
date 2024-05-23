import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/models/upload_file_response_model.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/admin/data/models/student_detail.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';
import 'package:grad_ease/features/timetable/data/models/time_table_model.dart';
import 'package:grad_ease/features/timetable/domain/entity/time_table_entity.dart'
    as tt;
import 'package:grad_ease/features/timetable/data/models/time_table_model.dart'
    as ttdto;

abstract interface class AdminRepository {
  Future<Either<Failure, List<StudentDetail>>> getAllStudents();
  Future<Either<Failure, StudentDetail>> approveStudents(String studentEmail);
  Future<Either<Failure, StudentDetail>> deleteStudents(String studentEmail);
  Future<Either<Failure, List<TimeTableModel>>> getAllTimeTable();
  Future<Either<Failure, tt.TimeTableEntity>> addTimeTable(
      ttdto.TimeTableModel timeTable);

  Future<Either<Failure, tt.TimeTableEntity>> updateTimeTable(
      ttdto.TimeTableModel timeTable);
  Future<Either<Failure, tt.TimeTableEntity>> deleteTimeTable(
      ttdto.TimeTableModel timeTable);

  Future<Either<Failure, List<CommunityEntity>>> getAllCommunties();
  Future<Either<Failure, UploadFileResponseModel>> uploadCommunityImage(
      String fileName, String filePath);
  Future<Either<Failure, CommunityEntity>> addCommunity(
    String communityName,
    String communityDescription,
    String profilePath,
    int year,
    String course,
  );
  Future<Either<Failure, CommunityEntity>> updateCommunity(
      String id,
      String communityName,
      String communityDescription,
      String profilePath,
      int year,
      String course,
      );
}

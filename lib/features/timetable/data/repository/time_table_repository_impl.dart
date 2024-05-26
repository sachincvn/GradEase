import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/entities/auth_detail_enity.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/timetable/data/data_source/time_table_remote_data_source.dart';
import 'package:grad_ease/features/timetable/domain/entity/time_table_entity.dart';
import 'package:grad_ease/features/timetable/domain/repository/time_table_repository.dart';

class TimeTableRepositortImpl implements TimeTableRepository {
  final LocalDetailsRepository _localDetailsRepository;
  final TimeTableRemoteDataSource _timeTableRemoteDataSource;
  late AuthDetailEntity? _studentEntity;

  TimeTableRepositortImpl(
    this._localDetailsRepository,
    this._timeTableRemoteDataSource,
  );
  @override
  Future<Either<Failure, TimeTableEntity>> getTimeTable(
      {String? course, int? year, String? section}) async {
    try {
      _studentEntity = _localDetailsRepository.getStudentDetail();
      final response = await _timeTableRemoteDataSource.getTimeTable(
          course ?? _studentEntity!.course!.name,
          year ?? _studentEntity!.courseYear!,
          section ?? _studentEntity!.section!);
      return right(response.data!.toEntity());
    } catch (e) {
      return left(Failure.handleException(e));
    }
  }
}

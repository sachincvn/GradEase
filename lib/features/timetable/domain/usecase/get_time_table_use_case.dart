import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/timetable/domain/entity/time_table_entity.dart';
import 'package:grad_ease/features/timetable/domain/repository/time_table_repository.dart';

class GetTimeTableUseCase
    implements UseCase<TimeTableEntity, GetTimeTableParams> {
  final TimeTableRepository timeTableRepository;

  GetTimeTableUseCase(this.timeTableRepository);
  @override
  Future<Either<Failure, TimeTableEntity>> call(
      GetTimeTableParams params) async {
    return await timeTableRepository.getTimeTable(
      course: params.course,
      section: params.section,
      year: params.year,
    );
  }
}

class GetTimeTableParams {
  final String? course;
  final int? year;
  final String? section;

  GetTimeTableParams(
      {required this.course, required this.year, required this.section});
}

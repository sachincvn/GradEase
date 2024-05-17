import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/timetable/domain/entity/time_table_entity.dart';

abstract interface class TimeTableRepository {
  Future<Either<Failure, TimeTableEntity>> getTimeTable({
    String? course,
    int? year,
    String? section,
  });
}

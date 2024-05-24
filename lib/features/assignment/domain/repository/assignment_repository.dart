import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/assignment/domain/entity/assignment_entity.dart';

abstract interface class AssignmentRepository {
  Future<Either<Failure, List<AssignmentEntity>>> getAssignment();
}

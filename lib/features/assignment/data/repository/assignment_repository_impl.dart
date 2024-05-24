import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/assignment/data/data_source/assignmnet_remote_data_source.dart';
import 'package:grad_ease/features/assignment/domain/entity/assignment_entity.dart';
import 'package:grad_ease/features/assignment/domain/repository/assignment_repository.dart';

class AssignmentRepositoryImpl implements AssignmentRepository {
  final LocalDetailsRepository _localDetailsRepository;
  final AssignmentRemoteDataSource _assignmentRemoteDataSource;

  AssignmentRepositoryImpl(
      this._localDetailsRepository, this._assignmentRemoteDataSource);

  @override
  Future<Either<Failure, List<AssignmentEntity>>> getAssignment() async {
    try {
      final studentDetail = _localDetailsRepository.getStudentDetail()!;
      final response = await _assignmentRemoteDataSource.getAssignment(
          studentDetail.course!.name, studentDetail.courseYear!);
      return right(response.data!.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/communities/data/data_source/community_remote_data_source.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';
import 'package:grad_ease/features/communities/domain/repository/communtiy_repository.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDataSource _communityRemoteDataSource;
  final LocalDetailsRepository _localDetailsRepository;

  CommunityRepositoryImpl(
    this._communityRemoteDataSource,
    this._localDetailsRepository,
  );

  @override
  Future<Either<Failure, List<CommunityEntity>>> getAllCommunties() async {
    try {
      final studentModel = _localDetailsRepository.getStudentDetail();
      final response = await _communityRemoteDataSource.getCommunites(
        studentModel!.course!.name,
        studentModel.courseYear!,
      );
      return right(response.data.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

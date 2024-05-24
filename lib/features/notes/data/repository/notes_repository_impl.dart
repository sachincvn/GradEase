import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/entities/auth_detail_enity.dart';
import 'package:grad_ease/core/common/models/upload_file_response_model.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/notes/data/data_source/notes_remote_data_source.dart';
import 'package:grad_ease/features/notes/domain/entity/note_entity.dart';
import 'package:grad_ease/features/notes/domain/repository/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NoteRemoteDataSource _noteRemoteDataSource;
  final LocalDetailsRepository _localDetailsRepository;
  late AuthDetailEntity? _studentEntity;
  NotesRepositoryImpl(
      this._noteRemoteDataSource, this._localDetailsRepository) {
    _studentEntity = _localDetailsRepository.getStudentDetail();
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> getNotes() async {
    try {
      final notes =
          await _noteRemoteDataSource.getNotes(_studentEntity!.courseYear!);
      return right(notes.data!.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, NoteEntity>> addNote(String title, String description,
      String filePath, String fileName) async {
    try {
      final uploadNoteResponse =
          await _noteRemoteDataSource.uploadNote(fileName, filePath);

      if (uploadNoteResponse.filePath.isNotEmpty) {
        final result = await _noteRemoteDataSource.addNote(
          title,
          description,
          uploadNoteResponse.filePath,
          _studentEntity!.fullName,
          _studentEntity!.email!,
          _studentEntity!.courseYear!,
        );
        return right(result.toEntity());
      } else {
        return left(Failure("Error while uploading an file"));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UploadFileResponseModel>> uploadNote(
      String filePath, String fileName) async {
    try {
      final response =
          await _noteRemoteDataSource.uploadNote(fileName, filePath);
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, NoteEntity>> deleteNote(String id) async {
    try {
      final response = await _noteRemoteDataSource.deletedNote(id);
      return right(response.toEntity());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

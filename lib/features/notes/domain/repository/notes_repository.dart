import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/models/upload_file_response_model.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/notes/domain/entity/note_entity.dart';

abstract interface class NotesRepository {
  Future<Either<Failure, List<NoteEntity>>> getNotes();
  Future<Either<Failure, NoteEntity>> addNote(
    String title,
    String description,
    String filePath,
    String fileNmae,
  );
  Future<Either<Failure, UploadFileResponseModel>> uploadNote(
    String filePath,
    String fileName,
  );

  Future<Either<Failure, NoteEntity>> deleteNote(String id);
}

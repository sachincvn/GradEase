import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/notes/domain/entity/note_entity.dart';
import 'package:grad_ease/features/notes/domain/repository/notes_repository.dart';

class DeleteNoteUseCase implements UseCase<NoteEntity, String> {
  final NotesRepository _notesRepository;

  DeleteNoteUseCase(this._notesRepository);

  @override
  Future<Either<Failure, NoteEntity>> call(String id) async {
    return await _notesRepository.deleteNote(id);
  }
}

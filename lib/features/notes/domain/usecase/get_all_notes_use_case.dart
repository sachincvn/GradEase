import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/notes/domain/entity/note_entity.dart';
import 'package:grad_ease/features/notes/domain/repository/notes_repository.dart';

class GetAllNotesUseCase implements UseCase<List<NoteEntity?>, NoParams> {
  final NotesRepository _notesRepository;

  GetAllNotesUseCase(this._notesRepository);
  @override
  Future<Either<Failure, List<NoteEntity?>>> call(NoParams params) async {
    return await _notesRepository.getNotes();
  }
}

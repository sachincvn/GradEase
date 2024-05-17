import 'package:fpdart/fpdart.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/remote/response_wrapper.dart';
import 'package:grad_ease/features/notes/domain/entity/note_entity.dart';
import 'package:grad_ease/features/notes/domain/repository/notes_repository.dart';

class AddNewNoteUseCase implements UseCase<NoteEntity, AddNoteParams> {
  final NotesRepository _notesRepository;

  AddNewNoteUseCase(this._notesRepository);
  @override
  Future<Either<Failure, NoteEntity>> call(AddNoteParams addNoteParams) async {
    return await _notesRepository.addNote(
        addNoteParams.title,
        addNoteParams.description,
        addNoteParams.filePath,
        addNoteParams.fileName);
  }
}

class AddNoteParams {
  final String filePath;
  final String fileName;
  final String title;
  final String description;

  AddNoteParams({
    required this.filePath,
    required this.fileName,
    required this.title,
    required this.description,
  });
}

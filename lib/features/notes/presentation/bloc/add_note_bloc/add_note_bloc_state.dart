part of 'add_note_bloc_bloc.dart';

@immutable
sealed class AddNoteBlocState {}

final class AddNoteBlocInitial extends AddNoteBlocState {}

final class AddNoteLoadingState extends AddNoteBlocState {}

final class AddNoteSuccessState extends AddNoteBlocState {
  final NoteEntity noteEntity;
  AddNoteSuccessState(this.noteEntity);
}

final class AddNoteFailureState extends AddNoteBlocState {
  final String? message;

  AddNoteFailureState(this.message);
}

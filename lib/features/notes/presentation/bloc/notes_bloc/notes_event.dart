part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

final class FetchAllNotes extends NotesEvent {}

final class InsertNewNoteEvent extends NotesEvent {
  final NoteEntity noteEntity;

  InsertNewNoteEvent(this.noteEntity);
}

final class RemoveNoteEvent extends NotesEvent {
  final String id;

  RemoveNoteEvent(this.id);
}

final class OpenUrlEvent extends NotesEvent {
  final String url;

  OpenUrlEvent(this.url);
}

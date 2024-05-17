part of 'notes_bloc.dart';

enum NotesStateStatus { initial, loading, success, error }

@immutable
class NotesState {
  final NotesStateStatus notesStateStatus;
  final List<NoteEntity?> notes;
  final String? errorMessage;

  const NotesState({
    this.notesStateStatus = NotesStateStatus.initial,
    this.notes = const [],
    this.errorMessage,
  });

  NotesState copyWith({
    NotesStateStatus? notesStateStatus,
    List<NoteEntity?>? notes,
    String? errorMessage,
  }) {
    return NotesState(
      notesStateStatus: notesStateStatus ?? this.notesStateStatus,
      notes: notes ?? this.notes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

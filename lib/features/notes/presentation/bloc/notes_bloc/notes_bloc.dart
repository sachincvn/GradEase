import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/features/notes/domain/entity/note_entity.dart';
import 'package:grad_ease/features/notes/domain/usecase/delete_note_use_case.dart';
import 'package:grad_ease/features/notes/domain/usecase/get_all_notes_use_case.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetAllNotesUseCase _getAllNotesUseCase;
  final DeleteNoteUseCase _deleteNoteUseCase;

  NotesBloc(
    this._getAllNotesUseCase,
    this._deleteNoteUseCase,
  ) : super(const NotesState()) {
    on<FetchAllNotes>(_onFetchNotes);
    on<InsertNewNoteEvent>(_onInsertNote);
    on<RemoveNoteEvent>(_onRemoveNote);
  }

  FutureOr<void> _onFetchNotes(
      NotesEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(notesStateStatus: NotesStateStatus.loading));

    final res = await _getAllNotesUseCase(NoParams());

    res.fold(
      (failure) => emit(emitErrorState(failure.message!)),
      (notes) => emit(NotesState(
        notesStateStatus: NotesStateStatus.success,
        errorMessage: null,
        notes: notes,
      )),
    );
  }

  NotesState emitErrorState(String error) {
    return (state.copyWith(
      notesStateStatus: NotesStateStatus.error,
      errorMessage: error,
    ));
  }

  FutureOr<void> _onRemoveNote(
    RemoveNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    final deletetPost = await _deleteNoteUseCase(event.id);
    deletetPost.fold(
        (l) => emit(emitErrorState(l.message!)),
        (r) => emit(state.copyWith(
              notesStateStatus: NotesStateStatus.success,
              errorMessage: null,
              notes: state.notes
                ..removeWhere((element) => element!.id == event.id),
            )));
  }

  FutureOr<void> _onInsertNote(
      InsertNewNoteEvent event, Emitter<NotesState> emit) {
    emit(state.copyWith(
      notesStateStatus: NotesStateStatus.success,
      errorMessage: null,
      notes: state.notes..insert(0, event.noteEntity),
    ));
  }
}

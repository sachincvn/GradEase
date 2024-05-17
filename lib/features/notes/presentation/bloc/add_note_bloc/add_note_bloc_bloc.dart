import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/notes/domain/entity/note_entity.dart';
import 'package:grad_ease/features/notes/domain/usecase/add_note_use_case.dart';

part 'add_note_bloc_event.dart';
part 'add_note_bloc_state.dart';

class AddNoteBloc extends Bloc<AddPostBlocEvent, AddNoteBlocState> {
  final AddNewNoteUseCase _addNewNoteUseCase;
  AddNoteBloc(this._addNewNoteUseCase) : super(AddNoteBlocInitial()) {
    on<AddNewNoteEvent>(_onAddNewNote);
  }

  FutureOr<void> _onAddNewNote(
    AddNewNoteEvent event,
    Emitter<AddNoteBlocState> emit,
  ) async {
    emit(AddNoteLoadingState());
    final result = await _addNewNoteUseCase(AddNoteParams(
      filePath: event.filePath,
      fileName: event.fileName,
      title: event.title,
      description: event.desctipiton,
    ));
    result.fold(
      (failure) => emit(AddNoteFailureState(failure.message!)),
      (note) => emit(AddNoteSuccessState(note)),
    );
  }
}

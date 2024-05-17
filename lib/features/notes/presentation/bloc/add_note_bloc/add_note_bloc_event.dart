part of 'add_note_bloc_bloc.dart';

@immutable
sealed class AddPostBlocEvent {}

final class AddNewNoteEvent extends AddPostBlocEvent {
  final String filePath;
  final String fileName;
  final String title;
  final String desctipiton;

  AddNewNoteEvent({
    required this.filePath,
    required this.title,
    required this.desctipiton,
    required this.fileName,
  });
}

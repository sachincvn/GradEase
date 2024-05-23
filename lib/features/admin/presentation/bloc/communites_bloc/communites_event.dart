part of 'communites_bloc.dart';

@immutable
sealed class CommunitesEvent {}

final class FetchAllCommunites extends CommunitesEvent {}

final class DeleteStudent extends CommunitesEvent {
  final StudentDetail studentDetail;

  DeleteStudent({required this.studentDetail});
}

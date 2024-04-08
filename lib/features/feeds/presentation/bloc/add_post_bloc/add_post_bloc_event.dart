part of 'add_post_bloc_bloc.dart';

@immutable
sealed class AddPostBlocEvent {}

final class AddNewPostEvent extends AddPostBlocEvent {
  final AddPostParams newPost;
  AddNewPostEvent(this.newPost);
}

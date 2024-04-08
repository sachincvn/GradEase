part of 'add_post_bloc_bloc.dart';

@immutable
sealed class AddPostBlocState {}

final class AddPostBlocInitial extends AddPostBlocState {}

final class AddPostLoadingState extends AddPostBlocState {}

final class AddPostSuccessState extends AddPostBlocState {}

final class AddPostFailureState extends AddPostBlocState {
  final String? message;

  AddPostFailureState(this.message);
}

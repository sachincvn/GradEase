part of 'edit_user_bloc.dart';

@immutable
sealed class EditUserState {}

final class EditUserInitial extends EditUserState {}

final class EditUserUpdatingState extends EditUserState {}

final class EditUserSuccessState extends EditUserState {}

final class EditUserErrorState extends EditUserState {
  final String message;

  EditUserErrorState(this.message);
}

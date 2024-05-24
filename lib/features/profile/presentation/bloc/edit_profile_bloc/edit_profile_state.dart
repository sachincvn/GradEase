part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileFailureSate extends EditProfileState {
  final String message;

  EditProfileFailureSate(this.message);
}

final class UpdatingProfileState extends EditProfileState {}

final class EditProfileSuccessState extends EditProfileState {}

final class StudentDataSuccessState extends EditProfileState {}

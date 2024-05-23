part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState({required this.message});
}

final class ProfileLoadedState extends ProfileState {
  final String studentName;
  final String studentEmail;
  final String studentProfile;

  ProfileLoadedState(
      {required this.studentName,
      required this.studentEmail,
      required this.studentProfile});
}

final class ProfileLoadingState extends ProfileState {}

final class ProfileSuccessState extends ProfileState {}

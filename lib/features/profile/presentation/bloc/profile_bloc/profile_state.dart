part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState({required this.message});
}

final class ProfileSuccessState extends ProfileState {}

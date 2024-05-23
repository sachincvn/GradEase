part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class StudentLogoutEvent extends ProfileEvent {}

final class FetchProfileStudentDetailEvent extends ProfileEvent {}

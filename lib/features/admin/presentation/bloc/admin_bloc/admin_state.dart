part of 'admin_bloc.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

final class AdminErrorState extends AdminState {
  final String errorMessage;

  AdminErrorState({required this.errorMessage});
}

final class AdminSuccessState extends AdminState {}

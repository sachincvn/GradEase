part of 'uucms_bloc.dart';

@immutable
sealed class UUCMSEvent {}

final class VerifyLoginEvent extends UUCMSEvent {}

final class UpdateLocalCookie extends UUCMSEvent {
  final String? cookie;

  UpdateLocalCookie({required this.cookie});
}

final class LogoutUUCMSEvent extends UUCMSEvent {}

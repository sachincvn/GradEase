part of 'uucms_internal_marks_bloc.dart';

@immutable
sealed class UUCMSInternalMarksEvent {}

final class GetInternalAssementEvent extends UUCMSInternalMarksEvent {
  final String intenalAssementUrl;

  GetInternalAssementEvent(this.intenalAssementUrl);
}

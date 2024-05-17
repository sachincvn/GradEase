part of 'uucms_registered_course_bloc.dart';

@immutable
sealed class UUCMSRegisteredCourseEvent {}

final class GetRegisteredCourseEvent extends UUCMSRegisteredCourseEvent {
  final String registeredCourseUrl;

  GetRegisteredCourseEvent(this.registeredCourseUrl);
}

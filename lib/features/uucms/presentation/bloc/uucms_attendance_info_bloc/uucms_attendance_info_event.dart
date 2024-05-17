part of 'uucms_attendance_info_bloc.dart';

@immutable
sealed class UUCMSAttendanceInfoEvent {}

final class GetAttendanceInfoEvent extends UUCMSAttendanceInfoEvent {
  final String attendanceUrl;

  GetAttendanceInfoEvent(this.attendanceUrl);
}

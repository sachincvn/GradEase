part of 'uucms_attendance_info_bloc.dart';

enum UUCMSAttendanceInfoStateStatus { inital, loading, success, error }

@immutable
class UUCMSAttendanceInfoState {
  final UUCMSAttendanceInfoStateStatus uucmsAttendanceIfnoStateStatus;
  final String? errorMessage;
  final UUCMSStudentDetails? uucmsStudentDetails;
  final List<AttendanceDetails> attendanceDetails;

  const UUCMSAttendanceInfoState({
    this.uucmsAttendanceIfnoStateStatus = UUCMSAttendanceInfoStateStatus.inital,
    this.errorMessage,
    this.attendanceDetails = const [],
    this.uucmsStudentDetails,
  });

  UUCMSAttendanceInfoState copyWith({
    UUCMSAttendanceInfoStateStatus? uucmsAttendanceIfnoStateStatus,
    String? errorMessage,
    List<AttendanceDetails>? attendanceDetails,
    UUCMSStudentDetails? uucmsStudentDetails,
  }) {
    return UUCMSAttendanceInfoState(
      uucmsAttendanceIfnoStateStatus:
          uucmsAttendanceIfnoStateStatus ?? this.uucmsAttendanceIfnoStateStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      attendanceDetails: attendanceDetails ?? this.attendanceDetails,
      uucmsStudentDetails: uucmsStudentDetails ?? this.uucmsStudentDetails,
    );
  }
}

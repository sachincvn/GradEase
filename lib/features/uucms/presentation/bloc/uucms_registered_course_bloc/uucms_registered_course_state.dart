part of 'uucms_registered_course_bloc.dart';

enum UUCMSRegisteredCourseStateStatus { inital, loading, success, error }

@immutable
class UUCMSRegisteredCourseState {
  final UUCMSRegisteredCourseStateStatus uucmsRegisteredCourseStateStatus;
  final String? errorMessage;
  final UUCMSStudentDetails? uucmsStudentDetails;
  final List<RegisterdCourse> internalAssessments;

  const UUCMSRegisteredCourseState({
    this.uucmsRegisteredCourseStateStatus =
        UUCMSRegisteredCourseStateStatus.inital,
    this.errorMessage,
    this.internalAssessments = const [],
    this.uucmsStudentDetails,
  });

  UUCMSRegisteredCourseState copyWith({
    UUCMSRegisteredCourseStateStatus? uucmsInternalMarksStateStatus,
    String? errorMessage,
    List<RegisterdCourse>? internalAssessments,
    UUCMSStudentDetails? uucmsStudentDetails,
  }) {
    return UUCMSRegisteredCourseState(
      uucmsRegisteredCourseStateStatus: uucmsInternalMarksStateStatus ??
          this.uucmsRegisteredCourseStateStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      internalAssessments: internalAssessments ?? this.internalAssessments,
      uucmsStudentDetails: uucmsStudentDetails ?? this.uucmsStudentDetails,
    );
  }
}

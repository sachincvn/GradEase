part of 'uucms_internal_marks_bloc.dart';

enum UUCMSInternalMarksStateStatus { inital, loading, success, error }

@immutable
class UUCMSInternalMarksState {
  final UUCMSInternalMarksStateStatus uucmsInternalMarksStateStatus;
  final String? errorMessage;
  final UUCMSStudentDetails? uucmsStudentDetails;
  final List<InternalAssessment> internalAssessments;

  const UUCMSInternalMarksState({
    this.uucmsInternalMarksStateStatus = UUCMSInternalMarksStateStatus.inital,
    this.errorMessage,
    this.internalAssessments = const [],
    this.uucmsStudentDetails,
  });

  UUCMSInternalMarksState copyWith({
    UUCMSInternalMarksStateStatus? uucmsInternalMarksStateStatus,
    String? errorMessage,
    List<InternalAssessment>? internalAssessments,
    UUCMSStudentDetails? uucmsStudentDetails,
  }) {
    return UUCMSInternalMarksState(
      uucmsInternalMarksStateStatus:
          uucmsInternalMarksStateStatus ?? this.uucmsInternalMarksStateStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      internalAssessments: internalAssessments ?? this.internalAssessments,
      uucmsStudentDetails: uucmsStudentDetails ?? this.uucmsStudentDetails,
    );
  }
}

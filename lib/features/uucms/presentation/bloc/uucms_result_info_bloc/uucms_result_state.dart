part of 'uucms_result_bloc.dart';

enum UUCMSExamResultStateStatus {
  inital,
  loading,
  success,
  error,
}

@immutable
class UUCMSExamResultState {
  final UUCMSExamResultStateStatus resultStatus;
  final UUCMSExamResultStateStatus studentInfoStatus;
  final UUCMSExamResultStateStatus examApplicationStatus;
  final String? errorMessage;
  final UUCMSStudentDetails? uucmsStudentDetails;
  final List<String>? termsNames;
  final List<ExamResultEntity> examResults;
  final String? selectedTerm;

  const UUCMSExamResultState(
      {this.resultStatus = UUCMSExamResultStateStatus.inital,
      this.studentInfoStatus = UUCMSExamResultStateStatus.inital,
      this.examApplicationStatus = UUCMSExamResultStateStatus.inital,
      this.errorMessage,
      this.examResults = const [],
      this.uucmsStudentDetails,
      this.termsNames = const [],
      this.selectedTerm});

  UUCMSExamResultState copyWith({
    UUCMSExamResultStateStatus? resultStatus,
    UUCMSExamResultStateStatus? studentInfoStatus,
    UUCMSExamResultStateStatus? examApplicationStatus,
    String? errorMessage,
    List<ExamResultEntity>? examResults,
    UUCMSStudentDetails? uucmsStudentDetails,
    List<String>? termsNames,
    String? selectedTerm,
  }) {
    return UUCMSExamResultState(
      resultStatus: resultStatus ?? this.resultStatus,
      studentInfoStatus: studentInfoStatus ?? this.studentInfoStatus,
      examApplicationStatus:
          examApplicationStatus ?? this.examApplicationStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      examResults: examResults ?? this.examResults,
      uucmsStudentDetails: uucmsStudentDetails ?? this.uucmsStudentDetails,
      termsNames: termsNames ?? this.termsNames,
      selectedTerm: selectedTerm ?? this.selectedTerm,
    );
  }
}

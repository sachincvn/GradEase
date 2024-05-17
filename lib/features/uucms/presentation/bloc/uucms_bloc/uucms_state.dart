part of 'uucms_bloc.dart';

enum UUCMSStateStatus { loading, loginState, success, error }

@immutable
class UUCMSState {
  final UUCMSStateStatus uucmsStateStatus;
  final String? errorMessage;
  final UUCMSStudentDetails? uucmsStudentDetails;
  final List<TermDetails> termDetail;

  const UUCMSState({
    this.uucmsStateStatus = UUCMSStateStatus.loginState,
    this.errorMessage,
    this.termDetail = const [],
    this.uucmsStudentDetails,
  });

  UUCMSState copyWith({
    UUCMSStateStatus? uucmsStateStatus,
    String? errorMessage,
    List<TermDetails>? termDetail,
    UUCMSStudentDetails? uucmsStudentDetails,
  }) {
    return UUCMSState(
      uucmsStateStatus: uucmsStateStatus ?? this.uucmsStateStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      termDetail: termDetail ?? this.termDetail,
      uucmsStudentDetails: uucmsStudentDetails ?? this.uucmsStudentDetails,
    );
  }
}

part of 'uucms_result_bloc.dart';

@immutable
sealed class UUCMSExamResultEvent {}

final class GetExamApplicationEvent extends UUCMSExamResultEvent {}

final class ViewResultEvent extends UUCMSExamResultEvent {
  final String termName;

  ViewResultEvent({required this.termName});
}

final class OnTermChangeEvent extends UUCMSExamResultEvent {
  final String selectedTerm;

  OnTermChangeEvent({required this.selectedTerm});
}

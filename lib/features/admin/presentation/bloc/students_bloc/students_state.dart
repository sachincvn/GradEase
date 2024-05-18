part of 'students_bloc.dart';

enum StudentsStateStatus { initial, loading, success, error }

@immutable
class StudentsState {
  final StudentsStateStatus status;
  final List<StudentDetail?> students;
  final String? errorMessage;
  final bool? isPendinApprovalStudentsSelected;

  const StudentsState({
    this.status = StudentsStateStatus.initial,
    this.students = const [],
    this.errorMessage,
    this.isPendinApprovalStudentsSelected = true,
  });

  StudentsState copyWith({
    StudentsStateStatus? status,
    List<StudentDetail?>? students,
    String? errorMessage,
    bool? isPendinApprovalStudentsSelected,
  }) {
    return StudentsState(
      status: status ?? this.status,
      students: students ?? this.students,
      errorMessage: errorMessage ?? this.errorMessage,
      isPendinApprovalStudentsSelected: isPendinApprovalStudentsSelected ??
          this.isPendinApprovalStudentsSelected,
    );
  }
}

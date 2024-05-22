part of 'students_bloc.dart';

@immutable
sealed class StudentsEvent {}

final class FetchAllStudents extends StudentsEvent {}

final class FilterAllStudents extends StudentsEvent {}

final class FilterPendingApprovalStudents extends StudentsEvent {}

final class ApproveStudent extends StudentsEvent {
  final StudentDetail studentDetail;

  ApproveStudent({required this.studentDetail});
}

final class DeleteStudent extends StudentsEvent {
  final StudentDetail studentDetail;

  DeleteStudent({required this.studentDetail});
}

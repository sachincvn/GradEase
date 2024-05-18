part of 'students_bloc.dart';

@immutable
sealed class StudentsEvent {}

final class FetchAllStudents extends StudentsEvent {}

final class FilterAllStudents extends StudentsEvent {}

final class FilterPendingApprovalStudents extends StudentsEvent {}

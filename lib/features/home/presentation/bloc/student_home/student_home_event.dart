part of 'student_home_bloc.dart';

@immutable
sealed class StudentHomeEvent {}

final class FetchInitalDataEvent extends StudentHomeEvent {}

final class FetchTimetableEvent extends StudentHomeEvent {}

final class RefreshHomeData extends StudentHomeEvent {}

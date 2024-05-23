part of 'student_home_bloc.dart';

@immutable
sealed class StudentHomeEvent {}

final class FetchInitalDataEvent extends StudentHomeEvent {}

part of 'student_home_bloc.dart';

@immutable
abstract class StudentHomeState {}

class StudentHomeInitial extends StudentHomeState {}

class StudentHomeLoadingState extends StudentHomeState {}

class StudentHomeSuccessState extends StudentHomeState {
  final StudentEntity studentEntity;

  StudentHomeSuccessState({required this.studentEntity});
}

class StudentHomeErrorState extends StudentHomeState {}

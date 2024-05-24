part of 'student_home_bloc.dart';

@immutable
abstract class StudentHomeState {}

class StudentHomeInitial extends StudentHomeState {}

class StudentHomeLoadingState extends StudentHomeState {}

class StudentHomeSuccessState extends StudentHomeState {
  final AuthDetailEntity studentEntity;
  final TimeTableEntity? timeTableEntity;

  StudentHomeSuccessState({required this.studentEntity, this.timeTableEntity});
}

class StudentHomeErrorState extends StudentHomeState {}

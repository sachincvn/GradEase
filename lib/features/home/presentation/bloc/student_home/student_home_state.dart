part of 'student_home_bloc.dart';

@immutable
abstract class StudentHomeState {}

class StudentHomeInitial extends StudentHomeState {}

class StudentHomeLoadingState extends StudentHomeState {}

class StudentHomeSuccessState extends StudentHomeState {
  final AuthDetailEntity? studentEntity;
  final TimeTableEntity? timeTableEntity;
  final String? toastMessage;

  StudentHomeSuccessState(
      {this.studentEntity, this.timeTableEntity, this.toastMessage});
}

class StudentHomeErrorState extends StudentHomeState {}

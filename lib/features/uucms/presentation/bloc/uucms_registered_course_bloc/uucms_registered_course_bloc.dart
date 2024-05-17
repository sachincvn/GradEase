import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/features/uucms/domain/repository/uucms_repository.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_bloc/uucms_bloc.dart';

import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

part 'uucms_registered_course_event.dart';
part 'uucms_registered_course_state.dart';

class UUCMSRegisteredCourseBloc
    extends Bloc<UUCMSRegisteredCourseEvent, UUCMSRegisteredCourseState> {
  final LocalDetailsRepository localDetailsRepository;
  final UUCMSRepository uucmsRepository;
  late List<RegisterdCourse> registeredCources = [];
  late UUCMSStudentDetails? uucmsStudentDetails;
  UUCMSRegisteredCourseBloc(this.localDetailsRepository, this.uucmsRepository)
      : super(const UUCMSRegisteredCourseState()) {
    on<GetRegisteredCourseEvent>(_onGetInternalAssement);
  }

  FutureOr<void> _onGetInternalAssement(GetRegisteredCourseEvent event,
      Emitter<UUCMSRegisteredCourseState> emit) async {
    try {
      registeredCources.clear();
      emit(state.copyWith(
        uucmsInternalMarksStateStatus: UUCMSRegisteredCourseStateStatus.loading,
      ));
      final registeredCourseUrl =
          "${RestResources.uucmsBaseUrl}${event.registeredCourseUrl}";
      final response = await http.get(Uri.parse(registeredCourseUrl));

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);

        var strongElements = document.querySelectorAll('.col-md-4 strong');
        if (strongElements.isNotEmpty) {
          var strongElements = document.querySelectorAll('.col-md-4 strong');
          final String usn = strongElements[0].text.trim();
          final String name = strongElements[1].text.trim();
          final String course = strongElements[3].text.trim();
          final String discipline = strongElements[4].text.trim();
          uucmsStudentDetails = UUCMSStudentDetails(
              usn: usn, name: name, course: course, discipline: discipline);
        }

        var tblCourseDetailsBody =
            document.getElementById('tblCourseDetailsBody');
        if (tblCourseDetailsBody != null) {
          var rows = tblCourseDetailsBody.getElementsByTagName('tr');
          for (var row in rows) {
            var cells = row.children;

            var courseType = cells[3].text.trim();
            var courseCode = cells[4].text.trim();
            var courseName = cells[5].text.trim();
            var courseCredit = cells[6].text.trim();
            var courseStatus = cells[7].text.trim();

            registeredCources.add(RegisterdCourse(
                courseCode: courseCode,
                courseName: courseName,
                courseCredit: courseCredit,
                courseStatus: courseStatus,
                courseType: courseType));
          }
        }
        if (registeredCources.isNotEmpty) {
          emit(state.copyWith(
            uucmsInternalMarksStateStatus:
                UUCMSRegisteredCourseStateStatus.success,
            internalAssessments: registeredCources,
            uucmsStudentDetails: uucmsStudentDetails,
          ));
        } else if (registeredCources.isEmpty) {
          emit(state.copyWith(
              uucmsInternalMarksStateStatus:
                  UUCMSRegisteredCourseStateStatus.error,
              errorMessage: "Data not found !"));
        }
      } else {
        emit(state.copyWith(
            uucmsInternalMarksStateStatus:
                UUCMSRegisteredCourseStateStatus.error,
            errorMessage: "Data not found !"));
      }
    } catch (e) {
      emit(state.copyWith(
          uucmsInternalMarksStateStatus: UUCMSRegisteredCourseStateStatus.error,
          errorMessage: e.toString()));
    }
  }
}

class RegisterdCourse {
  final String? courseCode;
  final String? courseName;
  final String? courseCredit;
  final String? courseStatus;
  final String? courseType;

  RegisterdCourse({
    required this.courseCode,
    required this.courseName,
    required this.courseCredit,
    required this.courseStatus,
    required this.courseType,
  });
}

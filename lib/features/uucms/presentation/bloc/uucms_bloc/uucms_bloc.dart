import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/features/uucms/domain/repository/uucms_repository.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

part 'uucms_event.dart';
part 'uucms_state.dart';

class UUCMSBloc extends Bloc<UUCMSEvent, UUCMSState> {
  final UUCMSRepository uucmsRepository;
  final LocalDetailsRepository localDetailsRepository;
  late List<TermDetails>? termDetails = [];
  late UUCMSStudentDetails? uucmsStudentDetails;
  UUCMSBloc(this.uucmsRepository, this.localDetailsRepository)
      : super(const UUCMSState()) {
    uucmsStudentDetails = null;
    on<VerifyLoginEvent>(_onVerifyLoginEvent);
    on<UpdateLocalCookie>(_onUpdateLocalCookie);
    on<LogoutUUCMSEvent>(_onLogoutUUMCS);
  }

  FutureOr<void> _onVerifyLoginEvent(
      VerifyLoginEvent event, Emitter<UUCMSState> emit) async {
    emit(state.copyWith(
      uucmsStateStatus: UUCMSStateStatus.loading,
    ));
    final isLogedIn = await uucmsRepository.verifyIsLoggedIn();
    if (isLogedIn) {
      await _getTermDetails(emit);
      uucmsStudentDetails = await getSutdentsDetails();
      if (uucmsStudentDetails != null) {
        emit(state.copyWith(uucmsStudentDetails: uucmsStudentDetails));
      }
    } else {
      emit(state.copyWith(
        errorMessage: null,
        uucmsStateStatus: UUCMSStateStatus.loginState,
      ));
    }
  }

  FutureOr<List<TermDetails>?> _onFetchInitalData() async {
    try {
      if (localDetailsRepository.getUUCMSLoginCookie() == null) {
        return null;
      }
      List<TermDetails> termDetails = [];
      final response = await http.get(
        Uri.parse(
            '${RestResources.uucmsBaseUrl}/CourseRegistrationByStudent/StudentCourses'),
        headers: {
          'Cookie': localDetailsRepository.getUUCMSLoginCookie()!,
        },
      );

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);
        var rows = document.querySelectorAll('#tblTermDetails tr');

        for (var row in rows) {
          var cells = row.querySelectorAll('td');
          var semester = cells[2].text.trim();
          var registeredCourseUrl =
              cells[3].querySelectorAll('a')[0].attributes['href'] ?? '';
          var internalAssessmentUrl =
              cells[3].querySelectorAll('a')[1].attributes['href'] ?? '';
          var attendanceUrl =
              cells[3].querySelectorAll('a')[2].attributes['href'] ?? '';

          termDetails.add(TermDetails(
              semester: semester,
              registeredCourseUrl: registeredCourseUrl,
              internalAssessmentUrl: internalAssessmentUrl,
              attendanceUrl: attendanceUrl));
        }
        return termDetails;
      } else {
        return null;
      }
    } catch (e) {
      state.copyWith(
          errorMessage: e.toString(), uucmsStateStatus: UUCMSStateStatus.error);
      return null;
    }
  }

  FutureOr<void> _onUpdateLocalCookie(
      UpdateLocalCookie event, Emitter<UUCMSState> emit) async {
    if (event.cookie != null && event.cookie!.isNotEmpty) {
      localDetailsRepository.updateUUCMSLoginCookie(event.cookie!);
      await _getTermDetails(emit);
    }
  }

  FutureOr<void> _onLogoutUUMCS(
      LogoutUUCMSEvent event, Emitter<UUCMSState> emit) {
    localDetailsRepository.removeUUCMSCookie();
    uucmsStudentDetails = null;
    emit(state.copyWith(
      errorMessage: null,
      termDetail: null,
      uucmsStateStatus: UUCMSStateStatus.loginState,
      uucmsStudentDetails: null,
    ));
  }

  Future<void> _getTermDetails(Emitter<UUCMSState> emit) async {
    termDetails = await _onFetchInitalData();
    if (termDetails != null) {
      emit(state.copyWith(
        uucmsStateStatus: UUCMSStateStatus.success,
        termDetail: termDetails,
      ));
    }
  }

  Future<UUCMSStudentDetails?> getSutdentsDetails() async {
    try {
      if (uucmsStudentDetails == null) {
        if (termDetails != null && termDetails!.isNotEmpty) {
          try {
            final registeredCourseUrl =
                "${RestResources.uucmsBaseUrl}${termDetails![0].registeredCourseUrl}";
            final response = await http.get(Uri.parse(registeredCourseUrl));

            if (response.statusCode == 200) {
              var document = parser.parse(response.body);

              var strongElements =
                  document.querySelectorAll('.col-md-4 strong');
              if (strongElements.isNotEmpty) {
                var strongElements =
                    document.querySelectorAll('.col-md-4 strong');
                final String usn = strongElements[0].text.trim();
                final String name = strongElements[1].text.trim();
                final String course = strongElements[3].text.trim();
                final String discipline = strongElements[4].text.trim();
                uucmsStudentDetails = UUCMSStudentDetails(
                  usn: usn,
                  name: name,
                  course: course,
                  discipline: discipline,
                );
                return uucmsStudentDetails;
              }
            }
          } catch (e) {
            return null;
          }
        }
        return null;
      } else {
        return uucmsStudentDetails;
      }
    } catch (e) {
      return null;
    }
  }
}

class TermDetails {
  final String semester;
  final String registeredCourseUrl;
  final String internalAssessmentUrl;
  final String attendanceUrl;

  TermDetails({
    required this.semester,
    required this.registeredCourseUrl,
    required this.internalAssessmentUrl,
    required this.attendanceUrl,
  });
}

class UUCMSStudentDetails {
  final String? usn;
  final String? name;
  final String? course;
  final String? discipline;

  UUCMSStudentDetails(
      {required this.usn,
      required this.name,
      required this.course,
      required this.discipline});
}

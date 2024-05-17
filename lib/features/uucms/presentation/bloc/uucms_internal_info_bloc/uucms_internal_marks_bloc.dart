import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/features/uucms/domain/repository/uucms_repository.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_bloc/uucms_bloc.dart';

import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

part 'uucms_internal_marks_event.dart';
part 'uucms_internal_marks_state.dart';

class UUCMSInternalMarksBloc
    extends Bloc<UUCMSInternalMarksEvent, UUCMSInternalMarksState> {
  final LocalDetailsRepository localDetailsRepository;
  final UUCMSRepository uucmsRepository;
  late List<InternalAssessment> internalAssements = [];
  late UUCMSStudentDetails uucmsStudentDetails;
  UUCMSInternalMarksBloc(this.localDetailsRepository, this.uucmsRepository)
      : super(const UUCMSInternalMarksState()) {
    on<GetInternalAssementEvent>(_onGetInternalAssement);
  }

  FutureOr<void> _onGetInternalAssement(GetInternalAssementEvent event,
      Emitter<UUCMSInternalMarksState> emit) async {
    try {
      internalAssements.clear();
      emit(state.copyWith(
        uucmsInternalMarksStateStatus: UUCMSInternalMarksStateStatus.loading,
      ));
      final internalAssementUrl =
          "${RestResources.uucmsBaseUrl}${event.intenalAssementUrl}";
      final response = await http.get(
        Uri.parse(internalAssementUrl),
        headers: {
          'Cookie': localDetailsRepository.getUUCMSLoginCookie()!,
        },
      );

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

        var rows = document.querySelectorAll('#tblTotalMarks tbody tr');

        for (var row in rows) {
          var cells = row.querySelectorAll('td');
          internalAssements.add(
            InternalAssessment(
              slNo: cells[0].text.trim(),
              courseCode: cells[1].text.trim(),
              courseName: cells[2].text.trim(),
              component: cells[3].text.trim(),
              maxMarks: cells[4].text.trim(),
              marksScored: cells[5].text.trim(),
            ),
          );
        }
        if (internalAssements.isNotEmpty) {
          emit(state.copyWith(
            uucmsInternalMarksStateStatus:
                UUCMSInternalMarksStateStatus.success,
            internalAssessments: internalAssements,
            uucmsStudentDetails: uucmsStudentDetails,
          ));
        } else if (internalAssements.isEmpty) {
          emit(state.copyWith(
              uucmsInternalMarksStateStatus:
                  UUCMSInternalMarksStateStatus.error,
              errorMessage: "Data not found !"));
        }
      } else {
        return null;
      }
    } catch (e) {}
  }
}

class InternalAssessment {
  final String slNo;
  final String courseCode;
  final String courseName;
  final String component;
  final String maxMarks;
  final String marksScored;

  InternalAssessment({
    required this.slNo,
    required this.courseCode,
    required this.courseName,
    required this.component,
    required this.maxMarks,
    required this.marksScored,
  });
}

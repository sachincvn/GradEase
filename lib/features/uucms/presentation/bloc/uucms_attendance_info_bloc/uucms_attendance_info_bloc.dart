import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_bloc/uucms_bloc.dart';

import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

part 'uucms_attendance_info_event.dart';
part 'uucms_attendance_info_state.dart';

class UUCMSAttendanceInfoBloc
    extends Bloc<UUCMSAttendanceInfoEvent, UUCMSAttendanceInfoState> {
  final LocalDetailsRepository localDetailsRepository;
  late List<AttendanceDetails> attendanceDetails = [];
  late UUCMSStudentDetails uucmsStudentDetails;
  UUCMSAttendanceInfoBloc(this.localDetailsRepository)
      : super(const UUCMSAttendanceInfoState()) {
    on<GetAttendanceInfoEvent>(_onGetInternalAssement);
  }

  FutureOr<void> _onGetInternalAssement(GetAttendanceInfoEvent event,
      Emitter<UUCMSAttendanceInfoState> emit) async {
    try {
      attendanceDetails.clear();
      emit(state.copyWith(
        uucmsAttendanceIfnoStateStatus: UUCMSAttendanceInfoStateStatus.loading,
      ));
      final internalAssementUrl =
          "${RestResources.uucmsBaseUrl}${event.attendanceUrl}";
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

        var rows = document.querySelectorAll('#tblAttendanceDetailsBody tr');

        for (var row in rows) {
          var cells = row.querySelectorAll('td');
          attendanceDetails.add(
            AttendanceDetails(
              slNo: cells[0].text.trim(),
              courseCode: cells[1].text.trim(),
              courseName: cells[2].text.trim(),
              component: cells[3].text.trim(),
              classesConducted: cells[4].text.trim(),
              classesAttended: cells[5].text.trim(),
              attendancePercentage: cells[6].text.trim(),
              status: cells[7].text.trim(),
              shortageOfAttendance: cells[8].text.trim(),
            ),
          );
        }
        if (attendanceDetails.isNotEmpty) {
          emit(state.copyWith(
            uucmsAttendanceIfnoStateStatus:
                UUCMSAttendanceInfoStateStatus.success,
            attendanceDetails: attendanceDetails,
            uucmsStudentDetails: uucmsStudentDetails,
          ));
        } else if (attendanceDetails.isEmpty) {
          emit(state.copyWith(
              uucmsAttendanceIfnoStateStatus:
                  UUCMSAttendanceInfoStateStatus.error,
              errorMessage: "Data not found !"));
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}

class AttendanceDetails {
  final String slNo;
  final String? courseCode;
  final String? courseName;
  final String? component;
  final String? classesConducted;
  final String? classesAttended;
  final String? attendancePercentage;
  final String? status;
  final String? shortageOfAttendance;

  AttendanceDetails({
    required this.slNo,
    this.courseCode,
    this.courseName,
    this.component,
    this.classesConducted,
    this.classesAttended,
    this.attendancePercentage,
    this.status,
    this.shortageOfAttendance,
  });
}

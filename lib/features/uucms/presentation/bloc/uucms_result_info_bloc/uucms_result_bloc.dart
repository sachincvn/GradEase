import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/features/uucms/domain/entity/exam_application_entity.dart';
import 'package:grad_ease/features/uucms/domain/entity/exam_result_model.dart';
import 'package:grad_ease/features/uucms/domain/repository/uucms_repository.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_bloc/uucms_bloc.dart';
import 'package:grad_ease/init_dependencies.dart';

part 'uucms_result_event.dart';
part 'uucms_result_state.dart';

class UUCMSExamResultBloc
    extends Bloc<UUCMSExamResultEvent, UUCMSExamResultState> {
  final UUCMSBloc uucmsBloc = serviceLocator<UUCMSBloc>();
  final LocalDetailsRepository localDetailsRepository;
  final UUCMSRepository uucmsRepository;
  late List<ExamApplicationEntity> examApplications = [];

  UUCMSExamResultBloc(this.localDetailsRepository, this.uucmsRepository)
      : super(const UUCMSExamResultState()) {
    on<GetExamApplicationEvent>(_onGetInternalAssement);
    on<ViewResultEvent>(_onViewResultEvent);
    on<OnTermChangeEvent>(_onTermChangeEvent);
  }

  FutureOr<void> _onGetInternalAssement(
      GetExamApplicationEvent event, Emitter<UUCMSExamResultState> emit) async {
    emit(state.copyWith(
      examApplicationStatus: UUCMSExamResultStateStatus.loading,
    ));

    final examApplication = await uucmsRepository.getExamApplication();
    final studentDetails = await uucmsBloc.getSutdentsDetails();
    if (studentDetails != null) {
      emit(state.copyWith(uucmsStudentDetails: studentDetails));
    }
    List<String> termNames = [];

    examApplication.fold((l) => null, (examApplications) {
      this.examApplications = examApplications;
      if (examApplications.isNotEmpty) {
        for (var examApplication in examApplications) {
          termNames.add(examApplication.termName!.trim());
        }
      }
    });

    if (termNames.isNotEmpty) {
      emit(state.copyWith(
        examApplicationStatus: UUCMSExamResultStateStatus.success,
        termsNames: termNames,
        selectedTerm: termNames[0],
      ));
    } else {
      emit(state.copyWith(
          examApplicationStatus: UUCMSExamResultStateStatus.inital,
          termsNames: null,
          errorMessage: "Not found"));
    }
  }

  FutureOr<void> _onViewResultEvent(
      ViewResultEvent event, Emitter<UUCMSExamResultState> emit) async {
    emit(state.copyWith(
      resultStatus: UUCMSExamResultStateStatus.loading,
    ));
    final selectedTermId = romanToInt(event.termName);
    final selectedExamApplication = examApplications
        .firstWhere((element) => element.termName!.trim() == event.termName);
    if (selectedExamApplication.enbs_id != null &&
        selectedTermId != null &&
        (selectedExamApplication.IsResultPublished ?? false)) {
      final examResults = await uucmsRepository.getExamResult(
        enbsid: selectedExamApplication.enbs_id.toString(),
        termId: selectedTermId.toString(),
      );

      examResults.fold((l) => null, (result) {
        emit(state.copyWith(
          resultStatus: UUCMSExamResultStateStatus.success,
          examResults: result,
        ));
      });
    }
  }

  int? romanToInt(String roman) {
    Map<String, int> romanMap = {
      'I': 1,
      'II': 2,
      'III': 3,
      'IV': 4,
      'I , III': 1,
      'II , IV': 2,
    };

    return romanMap[roman];
  }

  FutureOr<void> _onTermChangeEvent(
      OnTermChangeEvent event, Emitter<UUCMSExamResultState> emit) {
    emit(state.copyWith(selectedTerm: event.selectedTerm));
  }
}

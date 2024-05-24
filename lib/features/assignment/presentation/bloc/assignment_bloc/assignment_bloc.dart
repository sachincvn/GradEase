import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/features/assignment/domain/entity/assignment_entity.dart';
import 'package:grad_ease/features/assignment/domain/repository/assignment_repository.dart';
import 'package:url_launcher/url_launcher.dart';

part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final AssignmentRepository _assignmentRepository;
  AssignmentBloc(this._assignmentRepository) : super(const AssignmentState()) {
    on<FetchAssignmentEvent>(_onFetchNotes);
    on<OpenUrlEvent>(_onOpenUrlEvent);
  }

  FutureOr<void> _onFetchNotes(
      AssignmentEvent event, Emitter<AssignmentState> emit) async {
    emit(state.copyWith(notesStateStatus: AssignmentStateStatus.loading));

    final res = await _assignmentRepository.getAssignment();

    res.fold(
      (failure) => emit(emitErrorState(failure.message!)),
      (notes) => emit(AssignmentState(
        notesStateStatus: AssignmentStateStatus.success,
        errorMessage: null,
        assignments: notes,
      )),
    );
  }

  AssignmentState emitErrorState(String error) {
    return (state.copyWith(
      notesStateStatus: AssignmentStateStatus.error,
      errorMessage: error,
    ));
  }

  FutureOr<void> _onOpenUrlEvent(
      OpenUrlEvent event, Emitter<AssignmentState> emit) async {
    final Uri url = Uri.parse('${RestResources.fileBaseUrl}${event.url}');
    if (!await launchUrl(url)) {
      emit(state.copyWith(
        notesStateStatus: AssignmentStateStatus.error,
        errorMessage: "Unable to open the file",
      ));
    }
  }
}

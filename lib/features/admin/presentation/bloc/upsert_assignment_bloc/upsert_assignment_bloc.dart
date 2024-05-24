import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/admin/domain/repository/admin_repository.dart';
import 'package:grad_ease/features/assignment/domain/entity/assignment_entity.dart';
part 'upsert_assignment_event.dart';
part 'upsert_assignment_state.dart';

class UpsertAssignmentBloc
    extends Bloc<UpsertAssignmentEvent, UpsertAssignmentState> {
  final AdminRepository _adminRepository;

  UpsertAssignmentBloc(this._adminRepository)
      : super(UpsertAssignmentInitial()) {
    on<UpsertAssignment>(_onSaveCommunityEvent);
  }

  FutureOr<void> _onSaveCommunityEvent(
      UpsertAssignment event, Emitter<UpsertAssignmentState> emit) async {
    try {
      emit(UpsertAssignmentLoadingState());
      if (event.assignmentEntity.id.isEmpty) {
        final response = await _adminRepository.addAssignment(
          event.assignmentEntity.title,
          event.assignmentEntity.description!,
          event.assignmentEntity.submittionDate,
          event.assignmentEntity.year,
          event.assignmentEntity.course,
        );
        response.fold(
          (l) => emit(UpsertAssignmentFailureState(l.message)),
          (r) => emit(UpsertAssignmentSuccessState(r)),
        );
      } else {
        final response = await _adminRepository.updateAssignment(
          event.assignmentEntity.id,
          event.assignmentEntity.title,
          event.assignmentEntity.description!,
          event.assignmentEntity.submittionDate,
          event.assignmentEntity.year,
          event.assignmentEntity.course,
        );
        response.fold((l) => emit(UpsertAssignmentFailureState(l.message)),
            (r) => emit(UpsertAssignmentSuccessState(r)));
      }
    } catch (e) {
      emit(UpsertAssignmentFailureState(e.toString()));
    }
  }
}

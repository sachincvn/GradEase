import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/feedback/domain/entity/feedback_entity.dart';
import 'package:grad_ease/features/feedback/domain/repository/feedback_repository.dart';

part 'admin_feedback_event.dart';
part 'admin_feedback_state.dart';

class AdminFeedbackBloc extends Bloc<AdminFeedbackEvent, AdminFeedbackState> {
  final FeedbackRepository _feedbackRepository;

  AdminFeedbackBloc(this._feedbackRepository) : super(AdminFeedbackInitial()) {
    on<AdminFeedbackEvent>((event, emit) async {
      try {
        final feedbacks = await _feedbackRepository.getAllFeedbacks();
        feedbacks.fold((l) => emit(AdminFeedbackError(message: l.message)),
            (r) => emit(AdminFeedbackSuccess(feedbacks: r)));
      } catch (e) {
        emit(AdminFeedbackError(message: e.toString()));
      }
    });
  }
}

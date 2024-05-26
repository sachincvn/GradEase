import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/feedback/domain/repository/feedback_repository.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FeedbackRepository _feedbackRepository;

  FeedbackBloc(this._feedbackRepository) : super(FeedbackInitial()) {
    on<SendFeedbackEvent>(_onSendFeedbackEvent);
  }

  FutureOr<void> _onSendFeedbackEvent(
      SendFeedbackEvent event, Emitter<FeedbackState> emit) async {
    try {
      emit(FeedbackSending());
      final sendFeedback =
          await _feedbackRepository.sendFeedback(event.message);
      sendFeedback.fold((l) => emit(FeedbackError(l.toString())),
          (r) => emit(FeedbackSuccess()));
    } catch (e) {
      emit(FeedbackError(e.toString()));
    }
  }
}

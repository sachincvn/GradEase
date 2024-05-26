part of 'feedback_bloc.dart';

@immutable
sealed class FeedbackState {}

final class FeedbackInitial extends FeedbackState {}

final class FeedbackSending extends FeedbackState {}

final class FeedbackSuccess extends FeedbackState {}

final class FeedbackError extends FeedbackState {
  final String message;

  FeedbackError(this.message);
}

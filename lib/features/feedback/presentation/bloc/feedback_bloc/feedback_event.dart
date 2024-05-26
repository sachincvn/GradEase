part of 'feedback_bloc.dart';

@immutable
sealed class FeedbackEvent {}

final class SendFeedbackEvent extends FeedbackEvent {
  final String message;

  SendFeedbackEvent({required this.message});
}

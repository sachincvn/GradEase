part of 'admin_feedback_bloc.dart';

@immutable
sealed class AdminFeedbackState {}

final class AdminFeedbackInitial extends AdminFeedbackState {}

final class AdminFeedbackSuccess extends AdminFeedbackState {
  final List<FeedbackEntity?> feedbacks;

  AdminFeedbackSuccess({required this.feedbacks});
}

final class AdminFeedbackLoading extends AdminFeedbackState {}

final class AdminFeedbackError extends AdminFeedbackState {
  final String? message;

  AdminFeedbackError({required this.message});
}

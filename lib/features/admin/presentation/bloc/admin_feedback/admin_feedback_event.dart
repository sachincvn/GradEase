part of 'admin_feedback_bloc.dart';

@immutable
sealed class AdminFeedbackEvent {}

final class FetchAllFeedbacks extends AdminFeedbackEvent {}

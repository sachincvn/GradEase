class FeedbackEntity {
  final String id;
  final String name;
  final String email;
  final String message;
  final DateTime createdAt;

  FeedbackEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.message,
    required this.createdAt,
  });
}

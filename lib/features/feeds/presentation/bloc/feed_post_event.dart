part of 'feed_post_bloc.dart';

@immutable
sealed class FeedPostEvent {}

final class FetchAllPosts extends FeedPostEvent {}

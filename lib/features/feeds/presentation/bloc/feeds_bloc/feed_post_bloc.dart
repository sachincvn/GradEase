import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:grad_ease/features/feeds/domain/usecase/getall_feed_post_usecase.dart';

part 'feed_post_event.dart';
part 'feed_post_state.dart';

class FeedPostBloc extends Bloc<FeedPostEvent, FeedPostState> {
  final GetAllFeedPostUseCase _getAllFeedPostUseCase;

  FeedPostBloc(this._getAllFeedPostUseCase) : super(FeedPostInitial()) {
    on<FeedPostEvent>((event, emit) => emit(FeedLoading()));
    on<FetchAllPosts>(_onFetchAllPost);
  }

  FutureOr<void> _onFetchAllPost(
      FetchAllPosts event, Emitter<FeedPostState> emit) async {
    final res = await _getAllFeedPostUseCase(NoParams());

    res.fold(
      (l) => emit(FeedFailure(l.message!)),
      (posts) => emit(FeedDisplaySuccess(posts.reversed.toList())),
    );
  }
}

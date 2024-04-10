import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:grad_ease/features/feeds/domain/usecase/dislike_post_use_case.dart';
import 'package:grad_ease/features/feeds/domain/usecase/getall_feed_post_usecase.dart';
import 'package:grad_ease/features/feeds/domain/usecase/like_post_use_case.dart';

part 'feed_post_event.dart';
part 'feed_post_state.dart';

class FeedPostBloc extends Bloc<FeedPostEvent, FeedPostState> {
  final GetAllFeedPostUseCase _getAllFeedPostUseCase;
  final LikePostUseCase _likePostUseCase;
  final DislikePostUseCase _dislikePostUseCase;

  FeedPostBloc(this._getAllFeedPostUseCase, this._dislikePostUseCase,
      this._likePostUseCase)
      : super(FeedPostInitial()) {
    on<FeedPostEvent>((event, emit) => emit(FeedLoading()));
    on<FetchAllPosts>(_onFetchAllPost);
    on<LikePost>(_onLikePost);
    on<DislikePost>(_onDislikePost);
  }

  FutureOr<void> _onFetchAllPost(
      FetchAllPosts event, Emitter<FeedPostState> emit) async {
    final res = await _getAllFeedPostUseCase(NoParams());

    res.fold(
      (l) => emit(FeedFailure(l.message!)),
      (posts) => emit(FeedDisplaySuccess(posts.reversed.toList())),
    );
  }

  FutureOr<void> _onLikePost(
      LikePost event, Emitter<FeedPostState> emit) async {
    final likePost = await _likePostUseCase(event.postId);

    likePost.fold(
      (l) => emit(LikePostFailure(l.message!)),
      (r) => emit(LikePostSuccess(r)),
    );
  }

  FutureOr<void> _onDislikePost(
      DislikePost event, Emitter<FeedPostState> emit) async {
    final dislikePost = await _dislikePostUseCase(event.postId);

    dislikePost.fold(
      (l) => emit(DisLikePostFailure(l.message!)),
      (r) => emit(DisLikePostSuccess(r)),
    );
  }
}

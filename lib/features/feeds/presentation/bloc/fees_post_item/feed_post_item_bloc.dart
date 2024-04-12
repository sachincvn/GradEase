import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:grad_ease/features/feeds/domain/usecase/dislike_post_use_case.dart';
import 'package:grad_ease/features/feeds/domain/usecase/like_post_use_case.dart';

part 'feed_post_item_event.dart';
part 'feed_post_item_state.dart';

class FeedPostItemBloc extends Bloc<FeedPostItemEvent, FeedPostItemState> {
  final LikePostUseCase _likePostUseCase;
  final DislikePostUseCase _dislikePostUseCase;

  final LocalDetailsRepository _localDetailsRepository;

  FeedPostItemBloc(this._likePostUseCase, this._dislikePostUseCase,
      this._localDetailsRepository)
      : super(FeedPostItemInitial()) {
    on<LikePostEvent>(_onLikePost);
    on<DislikePostEvent>(_onDislikePost);
  }

  FutureOr<void> _onLikePost(
    LikePostEvent event,
    Emitter<FeedPostItemState> emit,
  ) async {
    final isAlreadyLiked = event.feedPostEntity.likedBy.any(
      (element) => element == _localDetailsRepository.getUserId(),
    );
    if (isAlreadyLiked) {
      return;
    }

    final likePost = await _likePostUseCase(event.feedPostEntity);

    likePost.fold(
      (l) => emit(LikePostFailure(l.message!)),
      (r) => emit(LikePostSuccess(r)),
    );
  }

  FutureOr<void> _onDislikePost(
      DislikePostEvent event, Emitter<FeedPostItemState> emit) async {
    final disLike = await _dislikePostUseCase(event.postId);

    disLike.fold(
      (l) => emit(DisLikePostFailure(l.message!)),
      (r) => emit(DisLikePostSuccess(r)),
    );
  }
}

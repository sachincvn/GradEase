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
    on<FeedPostItemInital>(_onFeedPostItemInital);
    on<LikePostEvent>(_onLikePost);
  }

  FutureOr<void> _onLikePost(
    LikePostEvent event,
    Emitter<FeedPostItemState> emit,
  ) async {
    if (_isAlreadyLiked(event.feedPostEntity)) {
      return;
    }

    final likePost = await _likePostUseCase(event.feedPostEntity);

    likePost.fold(
      (l) => emit(FeedPostItemFailure(l.message!)),
      (r) => emit(FeedPostItemSucess(r)),
    );
  }

  FutureOr<void> _onFeedPostItemInital(
    FeedPostItemInital event,
    Emitter<FeedPostItemState> emit,
  ) async {
    final feedPostitem = event.feedPost.copyWith(
      isPostLiked: _isAlreadyLiked(event.feedPost),
      isPostDisliked: _isAlreadyDisLiked(event.feedPost),
    );
    emit(FeedPostItemSucess(feedPostitem));
  }

  bool _isAlreadyLiked(FeedPostEntity feedPostEntity) {
    return feedPostEntity.likedBy.any(
      (element) => element == _localDetailsRepository.getUserId(),
    );
  }

  bool _isAlreadyDisLiked(FeedPostEntity feedPostEntity) {
    return feedPostEntity.dislikedBy.any(
      (element) => element == _localDetailsRepository.getUserId(),
    );
  }
}

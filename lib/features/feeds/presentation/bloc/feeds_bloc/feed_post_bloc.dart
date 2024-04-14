import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/core/local/local_repository.dart';
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
  final LocalDetailsRepository _localDetailsRepository;

  FeedPostBloc(
    this._getAllFeedPostUseCase,
    this._likePostUseCase,
    this._dislikePostUseCase,
    this._localDetailsRepository,
  ) : super(const FeedPostState()) {
    on<FetchAllPosts>(_onFetchAllPost);
    on<LikePostEvent>(_onLikePost);
    on<DislikePostEvent>(_onDislikePost);
    on<AddPostEvent>(_onAddPost);
  }

  FutureOr<void> _onFetchAllPost(
    FetchAllPosts event,
    Emitter<FeedPostState> emit,
  ) async {
    emit(state.copyWith(feedPostStateStatus: FeedPostStateStatus.loading));

    final res = await _getAllFeedPostUseCase(NoParams());

    res.fold(
      (failure) => emit(emitErrorState(failure.message!)),
      (posts) => emit(FeedPostState(
        feedPostStateStatus: FeedPostStateStatus.success,
        errorMessage: null,
        posts: posts,
      )),
    );
  }

  bool isLiked(FeedPostEntity feedPostEntity) => feedPostEntity.likedBy
      .any((element) => element == _localDetailsRepository.getUserId());

  bool isDisLiked(FeedPostEntity feedPostEntity) => feedPostEntity.dislikedBy
      .any((element) => element == _localDetailsRepository.getUserId());

  FutureOr<void> _onLikePost(
    LikePostEvent event,
    Emitter<FeedPostState> emit,
  ) async {
    if (isLiked(event.feedPostEntity)) {
      return;
    }
    final likePost = await _likePostUseCase(event.feedPostEntity);

    likePost.fold(
      (failure) => emit(emitErrorState(failure.message!)),
      (result) {
        final updatedPosts = List<FeedPostEntity?>.from(state.posts);
        final index = updatedPosts
            .indexWhere((post) => post?.id == event.feedPostEntity.id);
        updatedPosts[index] = result;
        emit(
          state.copyWith(
              feedPostStateStatus: FeedPostStateStatus.success,
              errorMessage: null,
              posts: updatedPosts),
        );
      },
    );
  }

  FeedPostState emitErrorState(String error) {
    return (state.copyWith(
      feedPostStateStatus: FeedPostStateStatus.error,
      errorMessage: error,
    ));
  }

  FutureOr<void> _onDislikePost(
    DislikePostEvent event,
    Emitter<FeedPostState> emit,
  ) async {
    final dislikePost = await _dislikePostUseCase(event.feedPostEntity);

    dislikePost.fold(
      (failure) => emit(emitErrorState(failure.message!)),
      (result) {
        final updatedPosts = List<FeedPostEntity?>.from(state.posts);
        final index = updatedPosts
            .indexWhere((post) => post?.id == event.feedPostEntity.id);
        updatedPosts[index] = result;
        emit(
          state.copyWith(
            feedPostStateStatus: FeedPostStateStatus.success,
            errorMessage: null,
            posts: updatedPosts,
          ),
        );
      },
    );
  }

  FutureOr<void> _onAddPost(AddPostEvent event, Emitter<FeedPostState> emit) {
    emit(state.copyWith(
      feedPostStateStatus: FeedPostStateStatus.success,
      errorMessage: null,
      posts: state.posts..insert(0, event.feedPostEntity),
    ));
  }
}

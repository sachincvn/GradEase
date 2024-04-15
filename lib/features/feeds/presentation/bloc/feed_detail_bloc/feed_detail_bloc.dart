import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/local/local_repository.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_reply_entity.dart';
import 'package:grad_ease/features/feeds/domain/usecase/add_reply_use_case.dart';
import 'package:grad_ease/features/feeds/domain/usecase/delete_post_use_case.dart';
import 'package:grad_ease/features/feeds/domain/usecase/get_replies_use_case.dart';

part 'feed_detail_event.dart';
part 'feed_detail_state.dart';

class FeedDetailBloc extends Bloc<FeedDetailEvent, FeedDetailState> {
  final GetRepliesUseCase _getRepliesUseCase;
  final AddReplyUseCase _addReplyUseCase;
  final DeletePostUseCase _deletePostUseCase;
  final LocalDetailsRepository _localDetailsRepository;
  List<FeedPostReplyEntity> _postReplies = [];

  FeedDetailBloc(
    this._getRepliesUseCase,
    this._addReplyUseCase,
    this._deletePostUseCase,
    this._localDetailsRepository,
  ) : super(const FeedDetailState()) {
    on<GetAllPostReplies>(_onGetAllPostReplies);
    on<AddNewReply>(_onAddNewReply);
    on<DeletePostEvent>(_onDeletePost);
  }

  FutureOr<void> _onGetAllPostReplies(
      GetAllPostReplies event, Emitter<FeedDetailState> emit) async {
    emit(state.copyWith(
      feedDetailStateStatus: FeedDetailStateStatus.loading,
    ));

    final postReplies = await _getRepliesUseCase(event.postId);
    postReplies.fold(
      (l) => emit(emitErrorState(l.message!)),
      (postReplies) {
        _postReplies = postReplies.reversed.toList();
        emit(state.copyWith(
          feedPostReplies: _postReplies,
          feedDetailStateStatus: FeedDetailStateStatus.success,
        ));
      },
    );
  }

  FutureOr<void> _onAddNewReply(
      AddNewReply event, Emitter<FeedDetailState> emit) async {
    emit(state.copyWith(isReplying: true));

    final reply = await _addReplyUseCase(event.addReply);
    reply.fold((l) => emit(emitErrorState(l.message!)), (r) {
      _postReplies.insert(
          0,
          FeedPostReplyEntity(
            content: event.addReply.content,
            author: _addReplyUseCase.authorEntity()!.toAuthor(),
          ));
      emit(state.copyWith(isReplying: false));
    });
  }

  FutureOr<void> _onDeletePost(
      DeletePostEvent event, Emitter<FeedDetailState> emit) async {
    final deletePost = await _deletePostUseCase(event.postId);
    emit(state.copyWith(isReplying: true));
    deletePost.fold(
      (l) => emit(emitErrorState(l.message!)),
      (r) => emit(state.copyWith(
        feedDetailStateStatus: FeedDetailStateStatus.deletedPost,
      )),
    );
  }

  FeedDetailState emitErrorState(String error) {
    return (state.copyWith(
      feedDetailStateStatus: FeedDetailStateStatus.error,
      errorMessage: error,
      isDeleting: false,
      isReplying: false,
    ));
  }

  bool canDeletePost(String postId) =>
      (postId == _localDetailsRepository.getUserId());
}

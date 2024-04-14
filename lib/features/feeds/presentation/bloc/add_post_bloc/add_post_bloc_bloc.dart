import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:grad_ease/features/feeds/domain/usecase/add_post_use_case.dart';

part 'add_post_bloc_event.dart';
part 'add_post_bloc_state.dart';

class AddPostBloc extends Bloc<AddPostBlocEvent, AddPostBlocState> {
  final AddPostUseCase _addPostUseCase;
  AddPostBloc(this._addPostUseCase) : super(AddPostBlocInitial()) {
    on<AddNewPostEvent>(_onAddNewPost);
  }

  FutureOr<void> _onAddNewPost(
    AddNewPostEvent event,
    Emitter<AddPostBlocState> emit,
  ) async {
    emit(AddPostLoadingState());
    final postId = await _addPostUseCase(event.newPost);
    postId.fold(
      (failure) => emit(AddPostFailureState(failure.message!)),
      (post) => emit(AddPostSuccessState(post)),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/communities/domain/entity/community_message_entity.dart';
import 'package:grad_ease/features/communities/domain/usecase/get_community_messages_use_case.dart';

part 'community_detail_event.dart';
part 'community_detail_state.dart';

class CommunityDetailBloc
    extends Bloc<CommunityDetailEvent, CommunityDetailState> {
  final GetCommunityMessagesUseCase _getCommunityMessagesUseCase;

  CommunityDetailBloc(this._getCommunityMessagesUseCase)
      : super(const CommunityDetailState()) {
    on<FetchAllCommunityMessages>(_fetchAllCommunityMessages);
  }

  FutureOr<void> _fetchAllCommunityMessages(
    FetchAllCommunityMessages event,
    Emitter<CommunityDetailState> emit,
  ) async {
    emit(state.copyWith(
      communityDetailStateStatus: CommunityDetailStateStatus.loading,
    ));

    final communityMessages =
        await _getCommunityMessagesUseCase(event.communityId);
    communityMessages.fold(
      (l) => emit(emitErrorState(l.message!)),
      (messages) => emit(state.copyWith(
        communityDetailStateStatus: CommunityDetailStateStatus.success,
        messages: messages,
      )),
    );
  }

  CommunityDetailState emitErrorState(String error) {
    return (state.copyWith(
      communityDetailStateStatus: CommunityDetailStateStatus.error,
      errorMessage: error,
    ));
  }
}

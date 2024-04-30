import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/communities/domain/entity/community_message_entity.dart';
import 'package:grad_ease/features/communities/domain/usecase/get_community_messages_use_case.dart';
import 'package:grad_ease/features/communities/domain/usecase/send_message_use_case.dart';

part 'community_detail_event.dart';
part 'community_detail_state.dart';

class CommunityDetailBloc
    extends Bloc<CommunityDetailEvent, CommunityDetailState> {
  final GetCommunityMessagesUseCase _getCommunityMessagesUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  late List<CommunityMessageEntity?> messages = [];
  CommunityDetailBloc(
    this._getCommunityMessagesUseCase,
    this._sendMessageUseCase,
  ) : super(const CommunityDetailState()) {
    on<FetchAllCommunityMessages>(_fetchAllCommunityMessages);
    on<SendCommunityMessage>(_sendCommunityMessage);
    on<FetchMoreCommunityMessages>(_fetchMoreCommunityMessages);
    on<AddNewRecivedMessage>(_onNewMessageRecived);
  }

  FutureOr<void> _fetchAllCommunityMessages(
    FetchAllCommunityMessages event,
    Emitter<CommunityDetailState> emit,
  ) async {
    emit(state.copyWith(
      communityDetailStateStatus: CommunityDetailStateStatus.loading,
    ));

    final communityMessages = await _getCommunityMessagesUseCase(
        GetCommunityMessagesParams(event.communityId));
    communityMessages.fold(
      (l) => emit(emitErrorState(l.message!)),
      (messages) {
        emit(state.copyWith(
          communityDetailStateStatus: CommunityDetailStateStatus.success,
          messages: messages,
        ));
        this.messages = messages;
      },
    );
  }

  FutureOr<void> _sendCommunityMessage(
      SendCommunityMessage event, Emitter<CommunityDetailState> emit) async {
    final sendMessage = await _sendMessageUseCase(
        SendMessageParams(event.message, event.communityId));
    sendMessage.fold(
      (failure) => emit(emitErrorState(failure.message!)),
      (response) {
        messages = event.messages ?? [];
        emit(state.copyWith(
          communityDetailStateStatus: CommunityDetailStateStatus.success,
          messages: messages,
        ));
      },
    );
  }

  CommunityDetailState emitErrorState(String error) {
    return (state.copyWith(
      communityDetailStateStatus: CommunityDetailStateStatus.error,
      errorMessage: error,
      messages: messages,
    ));
  }

  FutureOr<void> _fetchMoreCommunityMessages(FetchMoreCommunityMessages event,
      Emitter<CommunityDetailState> emit) async {
    final communityMessages = await _getCommunityMessagesUseCase(
        GetCommunityMessagesParams(
            event.communityId, event.page, event.pageLimit));
    communityMessages.fold(
      (l) => emit(emitErrorState(l.message!)),
      (newMessages) {
        messages = [...messages, ...newMessages];
        emit(state.copyWith(
          communityDetailStateStatus: CommunityDetailStateStatus.success,
          messages: messages,
          hasMoreData: newMessages.isNotEmpty,
        ));
      },
    );
  }

  FutureOr<void> _onNewMessageRecived(
      AddNewRecivedMessage event, Emitter<CommunityDetailState> emit) {
    messages.insert(0, event.communityMessageEntity);
    emit(state.copyWith(
      communityDetailStateStatus: CommunityDetailStateStatus.success,
      messages: messages,
    ));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/usecase/usecase.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';
import 'package:grad_ease/features/communities/domain/usecase/get_community_use_case.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final GetCommunityUseCase _getCommunityUseCase;

  CommunityBloc(this._getCommunityUseCase) : super(const CommunityState()) {
    on<FetchAllCommunites>(_fetchAllCommunites);
  }

  FutureOr<void> _fetchAllCommunites(
      FetchAllCommunites event, Emitter<CommunityState> emit) async {
    emit(state.copyWith(communityStateStatus: CommunityStateStatus.loading));

    final res = await _getCommunityUseCase(NoParams());

    res.fold(
      (failure) => emit(emitErrorState(failure.message!)),
      (communites) => emit(CommunityState(
        communityStateStatus: CommunityStateStatus.success,
        errorMessage: null,
        communites: communites,
      )),
    );
  }

  CommunityState emitErrorState(String error) {
    return (state.copyWith(
      communityStateStatus: CommunityStateStatus.error,
      errorMessage: error,
    ));
  }
}

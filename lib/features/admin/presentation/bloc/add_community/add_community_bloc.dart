import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/admin/domain/repository/admin_repository.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';
import 'package:grad_ease/features/timetable/data/models/time_table_model.dart';

part 'add_community_event.dart';
part 'add_community_state.dart';

class AddCommunityBloc extends Bloc<AddCommunityEvent, AddCommunityState> {
  final AdminRepository _adminRepository;

  AddCommunityBloc(this._adminRepository) : super(AddCommunityInitial()) {
    on<SaveCommunityEvent>(_onSaveTimeTableEvent);
    on<UpdateCommunityEvent>(_onUpdateTimeTableEvent);
  }

  FutureOr<void> _onSaveTimeTableEvent(
      SaveCommunityEvent event, Emitter<AddCommunityState> emit) async {
    emit(AddCommunityLoadingState());
    final response = await _adminRepository.uploadCommunityImage(
        event.profileName, event.profilePath);
    response.fold(
      (failure) =>
          emit(AddCommunityFailureState("Error while uploading image")),
      (imageResponse) async {
        final createPost = await _adminRepository.addCommunity(
            event.communityName,
            event.communityDescription,
            imageResponse.filePath,
            event.year,
            event.course);
        createPost.fold(
            (l) => emit(AddCommunityFailureState("Something went wrong")),
            (r) => AddCommunitySuccessState(r));
      },
    );
  }

  FutureOr<void> _onUpdateTimeTableEvent(
      UpdateCommunityEvent event, Emitter<AddCommunityState> emit) async {}
}

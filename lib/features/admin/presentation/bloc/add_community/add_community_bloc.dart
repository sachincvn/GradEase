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
            (r) => emit(AddCommunitySuccessState(r)));
      },
    );
  }

  FutureOr<void> _onUpdateTimeTableEvent(
      UpdateCommunityEvent event, Emitter<AddCommunityState> emit) async {
    if(event.profilePath != event.profilePath){
      //add new image and update
      final updateImage = await _adminRepository.uploadCommunityImage(event.profileName, event.profilePath);
      updateImage.fold((l) => emit(AddCommunityFailureState("Failed while uploading image")), (r) {
        updateCommunity(r.filePath, event, emit);
      });
      return;
    }
    updateCommunity(event.profilePath, event, emit);
  }

  Future<void> updateCommunity(String profilePath,UpdateCommunityEvent event, Emitter<AddCommunityState> emit) async{
    final updateCommunity = await _adminRepository.updateCommunity(event.communityId, event.communityName, event.communityDescription, event.profilePath, event.year, event.course);
    updateCommunity.fold((l) => emit(AddCommunityFailureState("Unable to update")), (r) => emit(AddCommunitySuccessState(r)));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/admin/domain/repository/admin_repository.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';
part 'add_community_event.dart';
part 'add_community_state.dart';

class AddCommunityBloc extends Bloc<AddCommunityEvent, AddCommunityState> {
  final AdminRepository _adminRepository;

  AddCommunityBloc(this._adminRepository) : super(AddCommunityInitial()) {
    on<SaveCommunityEvent>(_onSaveCommunityEvent);
    on<UpdateCommunityEvent>(_onUpdateCommunityEvent);
    on<UpdateCommunityDataEvent>(_onUpdaCommunityData);
    on<AddCommunityDataEvent>(_onAddCommunityData);
    on<DeleteCommunityEvent>(_onDeleteCommunityEvent);
  }

  FutureOr<void> _onSaveCommunityEvent(
      SaveCommunityEvent event, Emitter<AddCommunityState> emit) async {
    emit(AddCommunityLoadingState());
    final response = await _adminRepository.uploadCommunityImage(
        event.profileName, event.profilePath);
    response.fold(
        (failure) =>
            emit(AddCommunityFailureState("Error while uploading image")),
        (imageResponse) => add(
              AddCommunityDataEvent(
                communityName: event.communityName,
                communityDescription: event.communityDescription,
                profilePath: imageResponse.filePath,
                profileName: event.profileName,
                year: event.year,
                course: event.course,
              ),
            ));
  }

  FutureOr<void> _onAddCommunityData(
      AddCommunityDataEvent event, Emitter<AddCommunityState> emit) async {
    final createPost = await _adminRepository.addCommunity(
        event.communityName,
        event.communityDescription,
        event.profilePath,
        event.year,
        event.course);
    createPost.fold(
        (l) => emit(AddCommunityFailureState("Something went wrong")),
        (r) => emit(AddCommunitySuccessState(r)));
  }

  FutureOr<void> _onUpdateCommunityEvent(
      UpdateCommunityEvent event, Emitter<AddCommunityState> emit) async {
    if (event.communityEntity.profileImage != event.profilePath) {
      final updateImage = await _adminRepository.uploadCommunityImage(
          event.profileName, event.profilePath);
      updateImage.fold(
          (l) => emit(AddCommunityFailureState("Failed while uploading image")),
          (r) => add(UpdateCommunityDataEvent(
              communityEntity: event.communityEntity,
              communityName: event.communityName,
              communityDescription: event.communityDescription,
              profilePath: r.filePath,
              profileName: event.profileName,
              year: event.year,
              course: event.course)));
      return;
    }
    add(UpdateCommunityDataEvent(
        communityEntity: event.communityEntity,
        communityName: event.communityName,
        communityDescription: event.communityDescription,
        profilePath: event.profilePath,
        profileName: event.profileName,
        year: event.year,
        course: event.course));
  }

  FutureOr<void> _onUpdaCommunityData(
      UpdateCommunityDataEvent event, Emitter<AddCommunityState> emit) async {
    final updateCommunity = await _adminRepository.updateCommunity(
        event.communityEntity.id,
        event.communityName,
        event.communityDescription,
        event.profilePath,
        event.year,
        event.course);
    updateCommunity.fold(
        (l) => emit(AddCommunityFailureState("Unable to update")),
        (r) => emit(AddCommunitySuccessState(r)));
  }

  FutureOr<void> _onDeleteCommunityEvent(
      DeleteCommunityEvent event, Emitter<AddCommunityState> emit) async {
    final deleteCommunity =
        await _adminRepository.deleteCommunity(event.communityId);
    deleteCommunity.fold(
        (l) => emit(AddCommunityFailureState("Failed to delete the community")),
        (r) => emit(AddCommunitySuccessState(r)));
  }
}

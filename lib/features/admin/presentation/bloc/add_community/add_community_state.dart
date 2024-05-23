part of 'add_community_bloc.dart';

@immutable
sealed class AddCommunityState {}

final class AddCommunityInitial extends AddCommunityState {}

final class AddCommunityLoadingState extends AddCommunityState {}

final class AddCommunitySuccessState extends AddCommunityState {
  final CommunityEntity communityEntity;
  AddCommunitySuccessState(this.communityEntity);
}

final class AddCommunityFailureState extends AddCommunityState {
  final String? message;

  AddCommunityFailureState(this.message);
}

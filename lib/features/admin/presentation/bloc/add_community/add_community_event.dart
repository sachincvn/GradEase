part of 'add_community_bloc.dart';

@immutable
sealed class AddCommunityEvent {}

final class SaveCommunityEvent extends AddCommunityEvent {
  final String communityName;
  final String communityDescription;
  final String profilePath;
  final String profileName;
  final int year;
  final String course;

  SaveCommunityEvent(
      {required this.communityName,
      required this.communityDescription,
      required this.profilePath,
      required this.profileName,
      required this.year,
      required this.course});
}

final class UpdateCommunityEvent extends AddCommunityEvent {
  final CommunityEntity communityEntity;
  final String communityName;
  final String communityDescription;
  final String profilePath;
  final String profileName;
  final int year;
  final String course;

  UpdateCommunityEvent(
      {required this.communityEntity,
      required this.communityName,
      required this.communityDescription,
      required this.profilePath,
      required this.profileName,
      required this.year,
      required this.course});
}

final class AddCommunityDataEvent extends AddCommunityEvent {
  final String communityName;
  final String communityDescription;
  final String profilePath;
  final String profileName;
  final int year;
  final String course;

  AddCommunityDataEvent(
      {required this.communityName,
      required this.communityDescription,
      required this.profilePath,
      required this.profileName,
      required this.year,
      required this.course});
}

final class UpdateCommunityDataEvent extends AddCommunityEvent {
  final CommunityEntity communityEntity;
  final String communityName;
  final String communityDescription;
  final String profilePath;
  final String profileName;
  final int year;
  final String course;

  UpdateCommunityDataEvent(
      {required this.communityEntity,
      required this.communityName,
      required this.communityDescription,
      required this.profilePath,
      required this.profileName,
      required this.year,
      required this.course});
}

final class DeleteCommunityEvent extends AddCommunityEvent {
  final String communityId;

  DeleteCommunityEvent({required this.communityId});
}

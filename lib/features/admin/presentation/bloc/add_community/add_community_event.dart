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
  final String communityId;
  final String communityName;
  final String communityDescription;
  final String profilePath;
  final String profileName;
  final int year;
  final String course;

  UpdateCommunityEvent({required this.communityId,required this.communityName, required this.communityDescription, required this.profilePath, required this.profileName, required this.year, required this.course});
}

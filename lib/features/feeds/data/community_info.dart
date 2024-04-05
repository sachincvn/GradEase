class CommunityInfo {
  final String title;
  final String description;
  final String groupImageUrl;

  CommunityInfo({
    required this.title,
    required this.description,
    required this.groupImageUrl,
  });
}

final List<CommunityInfo> communityList = [
  CommunityInfo(
    title: "MCA 3rd Sem",
    description: "Get all updates regarding 3rd semester",
    groupImageUrl:
        "https://cdn-icons-png.freepik.com/512/7152/7152226.png?filename=speaker_7152226.png&fd=1",
  ),
  // CommunityInfo(
  //   title: "Job Opportunities",
  //   description: "Latest job openings and career opportunities",
  //   groupImageUrl:
  //       "https://cdn-icons-png.freepik.com/512/2936/2936677.png?filename=job_2936677.png&fd=1",
  // ),
  CommunityInfo(
    title: "Study Materials",
    description: "Access study materials and resources for your subjects",
    groupImageUrl:
        "https://cdn-icons-png.freepik.com/512/3330/3330314.png?filename=book_3330314.png&fd=1",
  ),
  CommunityInfo(
    title: "Events & Announcements",
    description:
        "Stay updated with events, seminars, and important announcements",
    groupImageUrl:
        "https://cdn-icons-png.freepik.com/512/12188/12188207.png?filename=meeting_12188207.png&fd=1",
  ),
];

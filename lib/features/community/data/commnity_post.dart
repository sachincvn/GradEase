class CommunityPost {
  final String title;
  final String description;
  final String name;
  final String course;
  final String profileUrl;
  final int likeCount;
  final int commentCount;

  CommunityPost({
    required this.title,
    required this.description,
    required this.name,
    required this.course,
    required this.profileUrl,
    required this.likeCount,
    required this.commentCount,
  });
}

final List<CommunityPost> communityPosts = [
  CommunityPost(
    title: "Post Title 1",
    description: "Description of post 1",
    name: "Sachin Chavan",
    course: "MCA | 2nd B",
    profileUrl: "https://source.unsplash.com/150x150/?portrait",
    likeCount: 42,
    commentCount: 2,
  ),
  CommunityPost(
    title: "Post Title 2",
    description: "Description of post 2",
    name: "John Doe",
    course: "MBA | 1st Year",
    profileUrl: "https://source.unsplash.com/150x150/?portrait",
    likeCount: 12,
    commentCount: 5,
  ),
  CommunityPost(
    title: "Post Title 3",
    description: "Description of post 3",
    name: "Jane Smith",
    course: "Engineering | 3rd Year",
    profileUrl: "https://source.unsplash.com/150x150/?portrait",
    likeCount: 30,
    commentCount: 8,
  ),
  CommunityPost(
    title: "Post Title 4",
    description: "Description of post 4",
    name: "Alice Johnson",
    course: "Medicine | Intern",
    profileUrl: "https://source.unsplash.com/150x150/?portrait",
    likeCount: 55,
    commentCount: 15,
  ),
  CommunityPost(
    title: "Post Title 5",
    description: "Description of post 5",
    profileUrl: "https://source.unsplash.com/150x150/?portrait",
    name: "Chris Brown",
    course: "Arts | Graduate",
    likeCount: 18,
    commentCount: 3,
  ),
];

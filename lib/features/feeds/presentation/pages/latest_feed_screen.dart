import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_ease/features/feeds/data/feed_post_model.dart';

import '../widgets/feed_post.dart';

class LatestFeedScreen extends StatelessWidget {
  const LatestFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: communityPosts.length,
      itemBuilder: (context, index) {
        return FeedPost(post: communityPosts[index]);
      },
    );
  }
}

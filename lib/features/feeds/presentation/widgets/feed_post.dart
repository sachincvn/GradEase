import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:grad_ease/features/feeds/presentation/pages/post_detail_screen.dart';
import 'package:page_transition/page_transition.dart';

class FeedPost extends StatelessWidget {
  final FeedPostEntity post;

  const FeedPost({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: PostDetailScreen(
              feedPost: post,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5, left: 14, right: 14, bottom: 10),
        padding: const EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF313a4d),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: ColorPallete.transparentColor,
                  minRadius: 28,
                  child: Image.network(
                    post.author?.profileImage ??
                        "https://cdn-icons-png.freepik.com/512/7088/7088431.png?filename=teen_7088431.png&fd=1",
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.author!.fullName!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      post.author!.email!,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              post.title!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              post.content!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            const Divider(),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.bubble_middle_bottom),
                  iconSize: 22,
                ),
                Text(
                  "1",
                  style: Theme.of(context).textTheme.labelMedium!,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.hand_thumbsdown),
                  iconSize: 22,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.hand_thumbsup_fill),
                  iconSize: 22,
                ),
                Text(
                  post.likedBy.length.toString(),
                  style: Theme.of(context).textTheme.labelMedium!,
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

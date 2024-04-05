import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/community/data/commnity_post.dart';

class CommunityScreen extends StatelessWidget {
  final CommunityPost post;

  const CommunityScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 14, right: 14, bottom: 10),
      padding: const EdgeInsets.all(10),
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
                  "https://cdn-icons-png.freepik.com/512/7088/7088431.png?filename=teen_7088431.png&fd=1",
                  height: 55,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    post.course,
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
            post.title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            post.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          const Divider(),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.bubble_middle_bottom),
              ),
              Text(
                post.commentCount.toString(),
                style: Theme.of(context).textTheme.labelLarge!,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.hand_thumbsdown),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.hand_thumbsup_fill),
              ),
              Text(
                post.likeCount.toString(),
                style: Theme.of(context).textTheme.labelLarge!,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}

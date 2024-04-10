import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/core/utils/show_snackbar.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:grad_ease/features/feeds/presentation/bloc/feeds_bloc/feed_post_bloc.dart';
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
            BlocConsumer<FeedPostBloc, FeedPostState>(
              listener: (context, state) {
                if (state is DisLikePostFailure) {
                  showSnackBar(context, state.error);
                }
                if (state is LikePostFailure) {
                  showSnackBar(context, state.error);
                }
              },
              builder: (context, state) {
                final isLiked = state is LikePostSuccess;
                final isDisLiked = state is DisLikePostSuccess;
                return Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                              child: PostDetailScreen(feedPost: post),
                              type: PageTransitionType.rightToLeft,
                            ));
                      },
                      icon: const Icon(CupertinoIcons.chat_bubble),
                      iconSize: 22,
                    ),
                    Text(
                      post.replies.length.toString(),
                      style: Theme.of(context).textTheme.labelMedium!,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        context.read<FeedPostBloc>().add(DislikePost(post.id));
                      },
                      icon: isDisLiked
                          ? const Icon(CupertinoIcons.arrowtriangle_down_fill)
                          : const Icon(CupertinoIcons.arrowtriangle_down),
                      iconSize: 22,
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<FeedPostBloc>().add(LikePost(post.id));
                      },
                      icon: isLiked
                          ? const Icon(CupertinoIcons.arrowtriangle_up_fill)
                          : const Icon(CupertinoIcons.arrowtriangle_up),
                      iconSize: 22,
                    ),
                    Text(
                      post.likedBy.length.toString(),
                      style: Theme.of(context).textTheme.labelMedium!,
                    ),
                    const SizedBox(width: 10),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

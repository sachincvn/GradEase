import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/core/utils/show_snackbar.dart';
import 'package:grad_ease/features/feeds/domain/enitity/feed_post_entity.dart';
import 'package:grad_ease/features/feeds/presentation/bloc/fees_post_item/feed_post_item_bloc.dart';
import 'package:grad_ease/features/feeds/presentation/pages/post_detail_screen.dart';
import 'package:page_transition/page_transition.dart';

class FeedPost extends StatefulWidget {
  final FeedPostEntity post;

  const FeedPost({
    super.key,
    required this.post,
  });

  @override
  State<FeedPost> createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  @override
  void initState() {
    super.initState();
    context.read<FeedPostItemBloc>().add(FeedPostItemInital(widget.post));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedPostItemBloc, FeedPostItemState>(
      listener: (context, state) {
        if (state is FeedPostItemFailure) {
          showErrorSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is FeedPostItemSucess) {
          final FeedPostEntity feedPostEntity = state.feedPostEntity!;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: PostDetailScreen(
                    feedPost: feedPostEntity,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(
                  top: 5, left: 14, right: 14, bottom: 10),
              padding:
                  const EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
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
                          feedPostEntity.author?.profileImage ??
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
                            feedPostEntity.author!.fullName!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            feedPostEntity.author!.email!,
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
                    feedPostEntity.title!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    feedPostEntity.content!,
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                child:
                                    PostDetailScreen(feedPost: feedPostEntity),
                                type: PageTransitionType.rightToLeft,
                              ));
                        },
                        icon: const Icon(CupertinoIcons.chat_bubble),
                        iconSize: 22,
                      ),
                      Text(
                        feedPostEntity.replies.length.toString(),
                        style: Theme.of(context).textTheme.labelMedium!,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          context
                              .read<FeedPostItemBloc>()
                              .add(DislikePostEvent(feedPostEntity.id));
                        },
                        icon: feedPostEntity.isPostDisliked ?? false
                            ? const Icon(CupertinoIcons.arrowtriangle_down_fill)
                            : const Icon(CupertinoIcons.arrowtriangle_down),
                        iconSize: 22,
                      ),
                      IconButton(
                        onPressed: () {
                          context
                              .read<FeedPostItemBloc>()
                              .add(LikePostEvent(feedPostEntity));
                        },
                        icon: feedPostEntity.isPostLiked ?? false
                            ? const Icon(CupertinoIcons.arrowtriangle_up_fill)
                            : const Icon(CupertinoIcons.arrowtriangle_up),
                        iconSize: 22,
                      ),
                      Text(
                        feedPostEntity.likedBy.length.toString(),
                        style: Theme.of(context).textTheme.labelMedium!,
                      ),
                      const SizedBox(width: 10),
                    ],
                  )
                ],
              ),
            ),
          );
        }
        if (state is FeedPostItemFailure) {
          return const SizedBox(
            child: Center(
              child: Text("data"),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

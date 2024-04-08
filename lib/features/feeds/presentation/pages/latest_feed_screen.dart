import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/core/utils/show_snackbar.dart';
import 'package:grad_ease/features/feeds/presentation/bloc/feeds_bloc/feed_post_bloc.dart';

import '../widgets/feed_post.dart';

class LatestFeedScreen extends StatefulWidget {
  const LatestFeedScreen({Key? key}) : super(key: key);

  @override
  State<LatestFeedScreen> createState() => _LatestFeedScreenState();
}

class _LatestFeedScreenState extends State<LatestFeedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FeedPostBloc>().add(FetchAllPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorPallete.blue500,
          onPressed: () {},
          child: const Icon(CupertinoIcons.add),
        ),
        body: BlocConsumer<FeedPostBloc, FeedPostState>(
          listener: (context, state) {
            if (state is FeedFailure) {
              showSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is FeedLoading) {
              return const Center(
                  child: SizedBox(
                height: 30,
                width: 40,
                child: CircularProgressIndicator(),
              ));
            }
            if (state is FeedDisplaySuccess) {
              final posts = state.posts;
              if (posts.isEmpty) {
                return const Center(
                  child: Text("No post found"),
                );
              }
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return FeedPost(post: posts[index]!);
                },
              );
            }
            return const SizedBox();
          },
        ));
  }
}

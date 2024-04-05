import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/feeds/data/feed_post_model.dart';

class CommunityDetailScreen extends StatelessWidget {
  final String communityTitle;
  const CommunityDetailScreen({Key? key, required this.communityTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: ColorPallete.whiteColor),
        centerTitle: true,
        title: Text(
          communityTitle,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: communityPosts.length,
                  itemBuilder: (context, index) {
                    return _communityPost(context);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: 'Enter message',
                      ),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.send))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _communityPost(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: ColorPallete.transparentColor,
                  minRadius: 28,
                  child: Image.network(
                      height: 44,
                      fit: BoxFit.cover,
                      "https://cdn-icons-png.freepik.com/512/7088/7088431.png?filename=teen_7088431.png&fd=1"),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Sachin Chavan",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w400),
                        children: [
                          const TextSpan(text: " - "),
                          TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(fontWeight: FontWeight.w300),
                            text: "10-4-2023 12:00 Am",
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "sachin@gmail.com",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontWeight: FontWeight.w200),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 60),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: "Login to stucdent account?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                      children: [
                        const TextSpan(text: "\n"),
                        const TextSpan(text: "\n"),
                        TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontWeight: FontWeight.w300),
                          text:
                              "Lorem ipsum dolor sit amet consectetur adipisicing elit. Enim, incidunt recusandae. Cupiditate nesciunt, rerum excepturi earum mollitia facilis hic tempore magni neque.Quis\n \nAecessitatibus praesentium non quam temporibus laborum consectetur doloribus? Quod recusandae reiciendis mollitia, error repellendus porro nam, cum quisquam perferendis, iusto autem temporibus facilis laborum? Fugiat, odit accusantium!",
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        const Divider(color: Color.fromARGB(110, 54, 67, 82)),
      ],
    );
  }
}

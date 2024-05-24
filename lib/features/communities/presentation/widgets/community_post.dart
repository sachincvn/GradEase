import 'package:flutter/material.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/extensions/string_extension.dart';
import 'package:grad_ease/features/communities/domain/entity/community_message_entity.dart';

class CommunityPost extends StatelessWidget {
  const CommunityPost({
    super.key,
    required this.message,
  });

  final CommunityMessageEntity message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                        "${RestResources.fileBaseUrl}${message.sender.profileImage}"),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: message.sender.fullName,
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
                            text: message.createdAt
                                .formatDateTime('yyyy-MM-dd hh:mm a'),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      message.sender.email ?? "sender@gmail.com",
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                          text: message.message,
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

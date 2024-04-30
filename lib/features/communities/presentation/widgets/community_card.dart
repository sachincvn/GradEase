import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';
import 'package:grad_ease/features/communities/presentation/pages/community_detail_screen.dart';
import 'package:page_transition/page_transition.dart';

class CommunityCard extends StatelessWidget {
  const CommunityCard({
    super.key,
    required this.communityEntity,
  });

  final CommunityEntity communityEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: CommunityDetailScreen(
              communityEntity: communityEntity,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color(0xFF313a4d),
            borderRadius: BorderRadius.circular(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorPallete.grey400,
                      maxRadius: 35,
                      child: Image.network(
                        fit: BoxFit.cover,
                        height: 50,
                        communityEntity.profileImage,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          communityEntity.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${communityEntity.members.length} memebers",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Join",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ))
              ],
            ),
            const SizedBox(height: 10),
            Text(
              communityEntity.description,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}

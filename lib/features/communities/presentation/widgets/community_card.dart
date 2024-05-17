import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';
import 'package:grad_ease/features/communities/presentation/pages/community_detail_screen.dart';
import 'package:page_transition/page_transition.dart';

class CommunityCard extends StatelessWidget {
  const CommunityCard({
    Key? key,
    required this.communityEntity,
  }) : super(key: key);

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
          color: const Color.fromARGB(255, 51, 55, 65),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        communityEntity.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        communityEntity.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement your button action here
                  },
                  child: Text(
                    'View',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

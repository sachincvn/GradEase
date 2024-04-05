import 'package:flutter/material.dart';
import 'package:grad_ease/features/communities/presentation/widgets/community_card.dart';
import 'package:grad_ease/features/feeds/data/community_info.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
      child: ListView.builder(
        itemCount: communityList.length,
        itemBuilder: (context, index) {
          return Padding(
            key: UniqueKey(), // Use UniqueKey as the key for each item
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CommunityCard(
              title: communityList[index].title,
              description: communityList[index].description,
              groupImageUrl: communityList[index].groupImageUrl,
            ),
          );
        },
      ),
    );
  }
}

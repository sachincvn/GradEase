import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/features/communities/presentation/bloc/community_bloc/community_bloc.dart';
import 'package:grad_ease/features/communities/presentation/widgets/community_card.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CommunityBloc>().add(FetchAllCommunites());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommunityBloc, CommunityState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.communityStateStatus == CommunityStateStatus.loading) {
          return const Center(
              child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ));
        } else if (state.communityStateStatus == CommunityStateStatus.success) {
          final communityList = state.communites;
          return Padding(
            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
            child: ListView.builder(
              itemCount: state.communites.length,
              itemBuilder: (context, index) {
                return Padding(
                  key: UniqueKey(),
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: CommunityCard(
                    title: communityList[index]!.name,
                    description: communityList[index]!.description,
                    groupImageUrl: communityList[index]!.profileImage,
                    groupMemebers: communityList[index]!.members.length,
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/admin/presentation/bloc/communites_bloc/communites_bloc.dart';
import 'package:grad_ease/features/admin/presentation/pages/upsert_community_screen.dart';
import 'package:page_transition/page_transition.dart';

class ManageCommunityScreen extends StatefulWidget {
  const ManageCommunityScreen({Key? key}) : super(key: key);

  @override
  State<ManageCommunityScreen> createState() => _ManageCommunityScreenState();
}

class _ManageCommunityScreenState extends State<ManageCommunityScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CommunitesBloc>().add(FetchAllCommunites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPallete.greyColor,
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const UpsertCommunityScreen(),
              ));
        },
        child: const Icon(CupertinoIcons.add),
      ),
      appBar: AppBar(
        title: const Text("Manage Comunnites"),
      ),
      body: SafeArea(
          child: BlocConsumer<CommunitesBloc, CommunitesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == CommunitesStateStatus.loading) {
            return const Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state.status == CommunitesStateStatus.error) {
            return Center(
              child: Text(state.errorMessage ?? "Something went wrong"),
            );
          } else if (state.status == CommunitesStateStatus.success) {
            return ListView.builder(
              itemCount: state.communites.length,
              itemBuilder: (context, index) {
                final community = state.communites[index]!;
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 14.0),
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
                              "${RestResources.imageBaseUrl}${community.profileImage}",
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  community.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  community.description,
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
                              'Edit',
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
                );
              },
            );
          }
          return const SizedBox();
        },
      )),
    );
  }
}

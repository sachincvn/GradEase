import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/communities/presentation/pages/community_screen.dart';
import 'package:grad_ease/features/notes/presentation/pages/notes_screen.dart';

class NotesTabScreen extends StatelessWidget {
  const NotesTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: false,
            toolbarHeight: 130,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Notes"),
                const SizedBox(height: 20),
                _buildTabBar(),
                const SizedBox(height: 10),
              ],
            )),
        body: const TabBarView(
          children: [
            NotesScreen(),
            CommunityScreen(),
          ],
        ),
      ),
    );
  }

  TabBar _buildTabBar() {
    return const TabBar(
      tabs: [
        Tab(text: 'Notes'),
        Tab(text: 'Assignmentes'),
      ],
      tabAlignment: TabAlignment.center,
      dividerColor: ColorPallete.transparentColor,
      indicatorColor: ColorPallete.whiteColor,
      labelColor: ColorPallete.whiteColor,
      unselectedLabelColor: ColorPallete.whiteColor,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }
}

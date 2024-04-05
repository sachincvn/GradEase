import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/communities/presentation/pages/community_screen.dart';
import 'package:grad_ease/features/feeds/presentation/pages/latest_feed_screen.dart';
import 'package:grad_ease/features/home/presentation/delegates/divider_delegate.dart';
import 'package:grad_ease/features/home/presentation/delegates/tab_bar_delegate.dart';
import 'package:grad_ease/features/home/presentation/widgets/clock_in_card.dart';
import 'package:grad_ease/features/home/presentation/widgets/home_screen_header.dart';
import 'package:grad_ease/features/home/presentation/widgets/quick_cards.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const HomeScreenHeader(),
              Expanded(
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      _sliverToBoxAdapterSizedBox(10),
                      const SliverToBoxAdapter(
                        child: ClockInCard(),
                      ),
                      _sliverToBoxAdapterSizedBox(18),
                      SliverToBoxAdapter(
                        child: _homeQuickCards(context),
                      ),
                      _sliverToBoxAdapterSizedBox(20),
                      SliverPersistentHeader(
                        delegate: DividerDelegate(),
                        pinned: true,
                      ),
                      SliverPersistentHeader(
                        delegate: TabBarDelegate(
                          tabBar: _buildTabBar(),
                        ),
                        pinned: true,
                      ),
                    ];
                  },
                  body: const TabBarView(
                    children: [
                      LatestFeedScreen(),
                      CommunityScreen(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TabBar _buildTabBar() {
    return const TabBar(
      tabs: [
        Tab(text: 'Discussion'),
        Tab(text: 'Communities'),
      ],
      tabAlignment: TabAlignment.fill,
      dividerColor: ColorPallete.transparentColor,
      indicatorColor: ColorPallete.whiteColor,
      labelColor: ColorPallete.whiteColor,
      unselectedLabelColor: ColorPallete.whiteColor,
      indicatorSize: TabBarIndicatorSize.label,
    );
  }

  Widget _homeQuickCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7),
      child: Row(
        children: [
          QuickCards(
              context: context,
              cardColor: const Color(0xFF0ba3de),
              textColor: ColorPallete.whiteColor,
              labelOne: "Semester",
              labelTwo: "3",
              labelThree: "MCA",
              imageUrl:
                  "https://cdn-icons-png.freepik.com/512/4735/4735829.png?filename=book_4735829.png&fd=1"),
          QuickCards(
              context: context,
              cardColor: const Color(0xFFead4ff),
              textColor: ColorPallete.backgroundColor,
              labelOne: "Performance",
              labelTwo: "70%",
              labelThree: "Average",
              imageUrl:
                  "https://cdn-icons-png.freepik.com/512/13434/13434630.png?filename=data-analytics_13434630.png&fd=1"),
        ],
      ),
    );
  }

  SliverToBoxAdapter _sliverToBoxAdapterSizedBox([
    double? height = 0,
    double? width = 0,
  ]) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
        width: width,
      ),
    );
  }
}

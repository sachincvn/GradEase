import 'package:flutter/material.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/home/presentation/widgets/clock_in_card.dart';
import 'package:grad_ease/features/home/presentation/widgets/community_card.dart';
import 'package:grad_ease/features/home/presentation/widgets/home_screen_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeScreenHeader(),
              const SizedBox(height: 30),
              const ClockInCard(),
              const SizedBox(height: 30),
              _homeQuickCards(context),
              const SizedBox(height: 30),
              const Divider(thickness: 4),
              _communites(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _communites(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Communites",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          const CommunityCard(
              title: "MCA 3rd Sem",
              description: "Get all updates regarding 3rd semester",
              groupImageUrl:
                  "https://cdn-icons-png.freepik.com/512/7152/7152226.png?filename=speaker_7152226.png&fd=1"),
          const SizedBox(height: 10.0),
          const CommunityCard(
              title: "Job Opportunities",
              description: "Latest job openings and career opportunities",
              groupImageUrl:
                  "https://cdn-icons-png.freepik.com/512/2936/2936677.png?filename=job_2936677.png&fd=1"),
          const SizedBox(height: 10.0),
          const CommunityCard(
              title: "Study Materials",
              description:
                  "Access study materials and resources for your subjects",
              groupImageUrl:
                  "https://cdn-icons-png.freepik.com/512/3330/3330314.png?filename=book_3330314.png&fd=1"),
          const SizedBox(height: 10.0),
          const CommunityCard(
              title: "Events & Announcements",
              description:
                  "Stay updated with events, seminars, and important announcements",
              groupImageUrl:
                  "https://cdn-icons-png.freepik.com/512/12188/12188207.png?filename=meeting_12188207.png&fd=1"),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _homeQuickCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7),
      child: Row(
        children: [
          _quickCards(
            context,
            const Color(0xFF0ba3de),
            ColorPallete.whiteColor,
            "Semester",
            "7",
            "MCA",
            "https://cdn-icons-png.freepik.com/512/4735/4735829.png?filename=book_4735829.png&fd=1",
          ),
          _quickCards(
            context,
            const Color(0xFFead4ff),
            ColorPallete.backgroundColor,
            "Performace",
            "70%",
            "Average",
            "https://cdn-icons-png.freepik.com/512/13434/13434630.png?filename=data-analytics_13434630.png&fd=1",
          ),
        ],
      ),
    );
  }

  Widget _quickCards(BuildContext context, Color cardColor, Color textColor,
      String labelOne, String labelTwo, String labelThree, String imageUrl) {
    return Expanded(
      child: Container(
        height: 125,
        margin: const EdgeInsets.only(left: 7, right: 7),
        padding: const EdgeInsets.only(top: 10, left: 10),
        decoration: BoxDecoration(
            color: cardColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              labelOne,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: textColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      labelTwo,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold, color: textColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      labelThree,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: textColor),
                    )
                  ],
                ),
                Image.network(height: 80, imageUrl)
              ],
            )
          ],
        ),
      ),
    );
  }
}

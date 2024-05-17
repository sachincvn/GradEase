import 'package:flutter/material.dart';
import 'package:grad_ease/core/constants/string_contants.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/communities/presentation/pages/community_screen.dart';
import 'package:grad_ease/features/home/presentation/widgets/clock_in_card.dart';
import 'package:grad_ease/features/home/presentation/widgets/home_screen_header.dart';
import 'package:grad_ease/features/home/presentation/widgets/quick_cards.dart';
import 'package:grad_ease/features/timetable/presentation/pages/class_schedule_screen.dart';
import 'package:grad_ease/features/uucms/presentation/pages/uucms_home_screen.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeScreenHeader(),
            const ClockInCard(),
            const SizedBox(height: 15),
            _homeQuickCards(context),
            const SizedBox(height: 15),
            const SizedBox(height: 5),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 4, left: 14, right: 14, bottom: 10),
              child: Text(
                "Communities",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const Expanded(child: CommunityScreen()),
          ],
        ),
      ),
    );
  }

  Widget _homeQuickCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 7),
      child: Row(
        children: [
          QuickCards(
            context: context,
            cardColor: const Color.fromARGB(228, 130, 149, 211),
            textColor: ColorPallete.whiteColor,
            labelName: "UUCMS Services",
            lottieAssest: LocalResourcesConstants.universityLottie,
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const UucmsHomeScreen(),
                ),
              );
            },
          ),
          QuickCards(
              context: context,
              cardColor: const Color.fromARGB(255, 120, 186, 212),
              textColor: ColorPallete.whiteColor,
              labelName: "Assignments",
              lottieAssest: LocalResourcesConstants.assignmentLottie),
          QuickCards(
            context: context,
            cardColor: const Color.fromARGB(209, 169, 231, 226),
            textColor: ColorPallete.whiteColor,
            labelName: "Timetable",
            lottieAssest: LocalResourcesConstants.scheduleLottie,
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const ClassScheduleScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

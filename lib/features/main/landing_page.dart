import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/feeds/presentation/pages/latest_feed_screen.dart';
import 'package:grad_ease/features/home/presentation/pages/home_screen.dart';
import 'package:grad_ease/features/main/bloc/landing_page_bloc.dart';
import 'package:grad_ease/features/notes/presentation/pages/notes_screen.dart';
import 'package:grad_ease/features/profile/presentation/pages/profile_screen.dart';
import 'package:grad_ease/features/timetable/presentation/pages/class_schedule_screen.dart';

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home_filled),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.feed_outlined),
    label: 'Discussion',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.notes_outlined),
    label: 'Notes',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.schedule_rounded),
    label: 'Timetable',
  ),
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.profile_circled),
    label: 'Profile',
  ),
];

const List<Widget> bottomNavScreen = <Widget>[
  HomeScreen(),
  LatestFeedScreen(),
  NotesScreen(),
  ClassScheduleScreen(),
  ProfileScreen(),
];

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LandingPageBloc, LandingPageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: bottomNavScreen.elementAt(state.tabIndex),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent, // Disable splash color
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              enableFeedback: true,
              backgroundColor: const Color.fromARGB(218, 25, 32, 37),
              items: bottomNavItems,
              currentIndex: state.tabIndex,
              selectedItemColor: ColorPallete.blue700,
              unselectedItemColor: ColorPallete.whiteColor,
              showUnselectedLabels: true,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                BlocProvider.of<LandingPageBloc>(context)
                    .add(TabChange(tabIndex: index));
              },
            ),
          ),
        );
      },
    );
  }
}

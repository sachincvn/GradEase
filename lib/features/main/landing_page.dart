import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/feeds/presentation/pages/latest_feed_screen.dart';
import 'package:grad_ease/features/home/presentation/pages/home_screen.dart';
import 'package:grad_ease/features/main/bloc/landing_page_bloc.dart';
import 'package:grad_ease/features/notes/presentation/pages/notes_tab_screen.dart';
import 'package:grad_ease/features/profile/presentation/pages/profile_screen.dart';

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
    icon: Icon(CupertinoIcons.profile_circled),
    label: 'Profile',
  ),
];

const List<Widget> bottomNavScreen = <Widget>[
  HomeScreen(),
  LatestFeedScreen(),
  NotesTabScreen(),
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
              backgroundColor: ColorPallete.backgroundColor,
              items: bottomNavItems,
              currentIndex: state.tabIndex,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              elevation: 0,
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

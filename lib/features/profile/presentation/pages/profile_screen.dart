import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/core/utils/show_snackbar.dart';
import 'package:grad_ease/features/auth/presentation/pages/student_login_screen.dart';
import 'package:grad_ease/features/feedback/presentation/feedback_screen.dart';
import 'package:grad_ease/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:grad_ease/features/profile/presentation/pages/edit_profile_screen.dart';
import 'package:grad_ease/features/profile/presentation/widgets/profile_menu_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfileStudentDetailEvent());
  }

  void _shareApp() {
    Share.share('Check out this awesome app: <Playstore Link>');
  }

  void _exitApp() {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileErrorState) {
              showErrorSnackBar(context, state.message);
            } else if (state is ProfileSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: const StudentLoginScreen(),
                ),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoadedState) {
              return Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 8, right: 8, bottom: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          "${RestResources.fileBaseUrl}${state.studentProfile}"),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.studentName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      state.studentEmail,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: const LinearGradient(
                          colors: [
                            ColorPallete.green500,
                            ColorPallete.blue500,
                            ColorPallete.blue700,
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const EditProfileScreen(),
                              ))
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorPallete.transparentColor,
                          shadowColor: ColorPallete.transparentColor,
                        ),
                        child: Text(
                          "Edit Profile",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: ColorPallete.grey400, height: .1),
                    const SizedBox(height: 40),
                    const ProfileMenuWidget(
                        title: "About", leadingIcon: Icon(Icons.settings)),
                    ProfileMenuWidget(
                      title: "Feedback",
                      leadingIcon: const Icon(Icons.feedback),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const FeedbackScreen(),
                            ));
                      },
                    ),
                    ProfileMenuWidget(
                      title: "Share app",
                      leadingIcon: const Icon(Icons.share),
                      onTap: _shareApp,
                    ),
                    const Divider(color: ColorPallete.grey400, height: .1),
                    ProfileMenuWidget(
                      title: "Exit",
                      leadingIcon: const Icon(Icons.info),
                      onTap: _exitApp,
                    ),
                    ProfileMenuWidget(
                      title: "Logout",
                      leadingIcon: const Icon(Icons.logout_rounded),
                      textColor: Colors.red,
                      trailingIcon: const Icon(null),
                      onTap: () {
                        context.read<ProfileBloc>().add(StudentLogoutEvent());
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      )),
    );
  }
}

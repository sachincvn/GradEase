import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/constants/string_contants.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/admin/presentation/pages/admin_home_screen.dart';
import 'package:grad_ease/features/auth/data/models/student_model.dart';
import 'package:grad_ease/features/communities/presentation/pages/community_screen.dart';
import 'package:grad_ease/features/home/presentation/bloc/student_home/student_home_bloc.dart';
import 'package:grad_ease/features/home/presentation/widgets/ongoing_class_widget.dart';
import 'package:grad_ease/features/home/presentation/widgets/home_screen_header.dart';
import 'package:grad_ease/features/home/presentation/widgets/quick_cards.dart';
import 'package:grad_ease/features/timetable/presentation/pages/class_schedule_screen.dart';
import 'package:grad_ease/features/uucms/presentation/pages/uucms_home_screen.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StudentHomeBloc>().add(FetchInitalDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<StudentHomeBloc, StudentHomeState>(
          builder: (context, state) {
            if (state is StudentHomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StudentHomeErrorState) {
              return const Center(child: Text("Error loading student data"));
            } else if (state is StudentHomeSuccessState) {
              final studentEntity = state.studentEntity;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeScreenHeader(
                    studentName: studentEntity.fullName,
                    profileImageUrl: studentEntity.profileImage,
                  ),
                  (studentEntity.role == RoleEnum.Admin ||
                          studentEntity.role == RoleEnum.Teacher)
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const AdminHomeScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromARGB(255, 255, 230, 212),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 2),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Admin Panel",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 197, 97, 0),
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Navigate to the admin panel to manage settings",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
                                              color:
                                                  ColorPallete.backgroundColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(
                                        255, 197, 97, 0), // Blue circle
                                  ),
                                  child: const Icon(
                                    Icons.admin_panel_settings_outlined,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const OnGoingClassWidget(),
                  const SizedBox(height: 15),
                  _homeQuickCards(context),
                  const SizedBox(height: 15),
                  const SizedBox(height: 5),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, left: 14, right: 14, bottom: 10),
                    child: Text("Communities",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w600)),
                  ),
                  const Expanded(child: CommunityScreen()),
                ],
              );
            } else {
              return Container();
            }
          },
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

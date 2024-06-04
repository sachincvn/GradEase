import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_button.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_bloc/uucms_bloc.dart';
import 'package:grad_ease/features/uucms/presentation/pages/attendance_info_screen.dart';
import 'package:grad_ease/features/uucms/presentation/pages/auth_uucms_web_screen.dart';
import 'package:grad_ease/features/uucms/presentation/pages/course_registered_info_screen.dart';
import 'package:grad_ease/features/uucms/presentation/pages/internal_info_screen.dart';
import 'package:grad_ease/features/uucms/presentation/pages/result_info_screen.dart';
import 'package:page_transition/page_transition.dart';

class UucmsHomeScreen extends StatefulWidget {
  const UucmsHomeScreen({Key? key}) : super(key: key);

  @override
  State<UucmsHomeScreen> createState() => _UucmsHomeScreenState();
}

class _UucmsHomeScreenState extends State<UucmsHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UUCMSBloc>().add(VerifyLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UUCMS Services"),
        actions: [
          BlocBuilder<UUCMSBloc, UUCMSState>(
            builder: (context, state) {
              if (state.uucmsStateStatus == UUCMSStateStatus.success) {
                return IconButton(
                    onPressed: () {
                      context.read<UUCMSBloc>().add(LogoutUUCMSEvent());
                    },
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: ColorPallete.errorColor,
                    ));
              }
              return const SizedBox();
            },
          )
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<UUCMSBloc, UUCMSState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.uucmsStateStatus == UUCMSStateStatus.loading) {
              return const Expanded(
                  child: Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              ));
            } else if (state.uucmsStateStatus == UUCMSStateStatus.loginState) {
              return _buildUUCMSLoginView();
            } else if (state.uucmsStateStatus == UUCMSStateStatus.success) {
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _buildServiceCard(
                        context,
                        "View Registered Course",
                        "Check your registered course",
                        const Color.fromARGB(
                            255, 212, 237, 255), // Light blue background
                        const Color.fromARGB(
                            255, 0, 122, 197), // Dark blue title color
                        Icons.arrow_forward_ios, // Custom icon
                        () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const CourseRegisteredInfoScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16), // Spacer between cards
                      _buildServiceCard(
                        context,
                        "View Internal Assessment",
                        "Check your internal assessment",
                        const Color.fromARGB(255, 255, 230, 212),
                        const Color.fromARGB(255, 197, 97, 0),
                        Icons.assignment_turned_in_outlined, // Custom icon
                        () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const InternalInfoScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildServiceCard(
                        context,
                        "View Attendance",
                        "Check your attendance",
                        const Color.fromARGB(255, 231, 212, 255),
                        const Color.fromARGB(255, 97, 0, 197),
                        Icons.calendar_today_outlined,
                        () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const AttendanceInfoScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16), // Spacer between cards
                      _buildServiceCard(
                        context,
                        "View Result",
                        "Check your result",
                        const Color.fromARGB(
                            255, 212, 255, 230), // Light green background
                        const Color.fromARGB(
                            255, 0, 197, 97), // Dark green title color
                        Icons.bar_chart_outlined, // Custom icon
                        () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const ResultInfoScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String title,
    String description,
    Color backgroundColor,
    Color titleColor,
    IconData iconData,
    VoidCallback onTap,
  ) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: backgroundColor,
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 75, 162, 216), // Blue circle
                ),
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: titleColor,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: titleColor,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildUUCMSLoginView() {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Login to UUCMS Ports to access the UUCMS Services",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: GradEaseButton(
                buttonText: "Click to login",
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: const AuthUUCMSWebScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

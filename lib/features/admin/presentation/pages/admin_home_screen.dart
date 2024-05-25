import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/utils/show_snackbar.dart';
import 'package:grad_ease/features/admin/presentation/bloc/admin_bloc/admin_bloc.dart';
import 'package:grad_ease/features/admin/presentation/pages/manage_assignment_screen.dart';
import 'package:grad_ease/features/admin/presentation/pages/manage_community_screen.dart';
import 'package:grad_ease/features/admin/presentation/pages/manage_users_screen.dart';
import 'package:grad_ease/features/admin/presentation/pages/time_table_screen.dart';
import 'package:grad_ease/features/auth/presentation/pages/admin_login_screen.dart';
import 'package:page_transition/page_transition.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Admin"),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: BlocConsumer<AdminBloc, AdminState>(
            listener: (context, state) {
              if (state is AdminErrorState) {
                showErrorSnackBar(context, state.errorMessage);
              } else if (state is AdminSuccessState) {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: const AdminLoginScreen(),
                  ),
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _buildServiceCard(
                      context,
                      "Manage Students",
                      "Manage students registeration, approve, edit, delete",
                      const Color.fromARGB(255, 212, 237, 255),
                      const Color.fromARGB(255, 0, 122, 197),
                      Icons.people_outline_sharp, // Custom icon
                      () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const ManageStudendsScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16), // Spacer between cards
                    _buildServiceCard(
                      context,
                      "Schedule / Timetable",
                      "Manage class timetable : add,update,edit,delete ",
                      const Color.fromARGB(255, 255, 230, 212),
                      const Color.fromARGB(255, 197, 97, 0),
                      Icons.schedule_outlined, // Custom icon
                      () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const TimeTableScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildServiceCard(
                      context,
                      "Communites",
                      "Manage communites : add,update,edit,delete",
                      const Color.fromARGB(255, 231, 212, 255),
                      const Color.fromARGB(255, 97, 0, 197),
                      Icons.group_sharp,
                      () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const ManageCommunityScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16), // Spacer between cards
                    _buildServiceCard(
                      context,
                      "Assignment",
                      "Add assignment to students",
                      const Color.fromARGB(
                          255, 212, 255, 230), // Light green background
                      const Color.fromARGB(
                          255, 0, 197, 97), // Dark green title color
                      Icons.assignment, // Custom icon
                      () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const ManageAssignmentScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        )));
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
}

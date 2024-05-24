import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/admin/data/models/student_detail.dart';
import 'package:grad_ease/features/admin/presentation/bloc/students_bloc/students_bloc.dart';
import 'package:grad_ease/features/admin/presentation/pages/edit_user_screen.dart';
import 'package:page_transition/page_transition.dart';

class ManageStudendsScreen extends StatefulWidget {
  const ManageStudendsScreen({Key? key}) : super(key: key);

  @override
  State<ManageStudendsScreen> createState() => _ManageStudendsScreenState();
}

class _ManageStudendsScreenState extends State<ManageStudendsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StudentsBloc>().add(FetchAllStudents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Students"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text('Pending Approvals'),
                    selected: context
                            .watch<StudentsBloc>()
                            .state
                            .isPendinApprovalStudentsSelected ??
                        false,
                    onSelected: (bool selected) {
                      context
                          .read<StudentsBloc>()
                          .add(FilterPendingApprovalStudents());
                    },
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text('All Students'),
                    selected: !(context
                            .watch<StudentsBloc>()
                            .state
                            .isPendinApprovalStudentsSelected ??
                        false),
                    onSelected: (bool selected) {
                      context.read<StudentsBloc>().add(FilterAllStudents());
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<StudentsBloc, StudentsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.status == StudentsStateStatus.loading) {
                    return const Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state.status == StudentsStateStatus.error) {
                    return Center(
                      child: Text(state.errorMessage ?? "Something went wrong"),
                    );
                  } else if (state.status == StudentsStateStatus.success) {
                    return ListView.builder(
                      itemCount: state.students.length,
                      itemBuilder: (context, index) {
                        final student = state.students[index];
                        return _buildStudentCardView(student!);
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentCardView(StudentDetail studentDetail) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: ColorPallete.grey500,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${studentDetail.fullName}',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Email: ${studentDetail.email ?? "-"}',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Mobile: ${studentDetail.studentPhone ?? "-"}',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  'ID: ${studentDetail.isApproved ?? false}',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          !(studentDetail.isApproved ?? false)
              ? Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<StudentsBloc>()
                            .add(ApproveStudent(studentDetail: studentDetail));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPallete.green500.withAlpha(150),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: Text(
                        'Approve',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<StudentsBloc>()
                            .add(DeleteStudent(studentDetail: studentDetail));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPallete.errorColor.withAlpha(150),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: Text(
                        'Reject',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: EditUserScreen(userDetail: studentDetail),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPallete.green500.withAlpha(150),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: Text(
                        'Edit',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<StudentsBloc>()
                            .add(DeleteStudent(studentDetail: studentDetail));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPallete.errorColor.withAlpha(150),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                      ),
                      child: Text(
                        'Delete',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

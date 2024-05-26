import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/widgets/confirmation_dailog.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/admin/presentation/bloc/admin_assignment/admin_assignment_bloc.dart';
import 'package:grad_ease/features/admin/presentation/pages/upsert_assignment_screen.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class ManageAssignmentScreen extends StatefulWidget {
  const ManageAssignmentScreen({Key? key}) : super(key: key);

  @override
  State<ManageAssignmentScreen> createState() => _ManageAssignmentScreenState();
}

class _ManageAssignmentScreenState extends State<ManageAssignmentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminAssignmnetBloc>().add(FetchAllAdminAssignmnet());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPallete.greyColor,
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const UpsertAssignmentScreen(),
              ));
        },
        child: const Icon(CupertinoIcons.add),
      ),
      appBar: AppBar(
        title: const Text("Assignments"),
      ),
      body: BlocConsumer<AdminAssignmnetBloc, AdminAssignmnetState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == AdminAssignmnetStateStatus.loading) {
            return const Center(
                child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(),
            ));
          } else if (state.status == AdminAssignmnetStateStatus.error) {
            return Center(
                child: Text(state.errorMessage ?? "Something went wrong"));
          } else if (state.status == AdminAssignmnetStateStatus.success) {
            return SafeArea(
                child: ListView.builder(
              itemCount: state.assignments.length,
              key: UniqueKey(),
              itemBuilder: (context, index) {
                final assignment = state.assignments[index];
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10, left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorPallete.lightGreyColor,
                  ),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Subject : ${assignment.title}",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Year : ${assignment.year}",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Course : ${assignment.course}",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Submittion : ${DateFormat('MMM d, yyyy').format(DateTime.parse(assignment.submittionDate))}",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: ColorPallete.green500.withAlpha(150),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: UpsertAssignmentScreen(
                                              assignmentEntity: assignment),
                                        ));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 15,
                                  ))),
                          const SizedBox(width: 10),
                          Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: ColorPallete.errorColor.withAlpha(150),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    showConfirmationDialog(
                                      context: context,
                                      title: 'Delete',
                                      content:
                                          'Are you sure you want to delete?',
                                      onConfirm: () {
                                        context.read<AdminAssignmnetBloc>().add(
                                            DeleteTimeAdminAssignmnet(
                                                assignment: assignment));
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 15,
                                  ))),
                        ],
                      )
                    ],
                  ),
                );
              },
            ));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

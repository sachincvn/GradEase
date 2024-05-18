import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/admin/presentation/bloc/students_bloc/students_bloc.dart';

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
          child: BlocConsumer<StudentsBloc, StudentsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.status == StudentsStateStatus.loading) {
                return const Center(
                    child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ));
              } else if (state.status == StudentsStateStatus.error) {
                return Center(
                    child: Text(state.errorMessage ?? "Something went wrong"));
              } else if (state.status == StudentsStateStatus.success) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ChoiceChip(
                            label: const Text('Pending Approvals'),
                            selected:
                                state.isPendinApprovalStudentsSelected ?? false,
                            onSelected: (bool selected) {
                              if (selected) {
                                context
                                    .read<StudentsBloc>()
                                    .add(FilterPendingApprovalStudents());
                              } else {
                                context
                                    .read<StudentsBloc>()
                                    .add(FilterAllStudents());
                              }
                            },
                          ),
                          const SizedBox(width: 10),
                          ChoiceChip(
                            label: const Text('All Students'),
                            selected:
                                !(state.isPendinApprovalStudentsSelected ??
                                    false),
                            onSelected: (bool selected) {
                              if (!selected) {
                                context
                                    .read<StudentsBloc>()
                                    .add(FilterPendingApprovalStudents());
                              } else {
                                context
                                    .read<StudentsBloc>()
                                    .add(FilterAllStudents());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.students.length,
                        itemBuilder: (context, index) {
                          final student = state.students[index]!;
                          return _buildStudentCardView(
                              student.fullName,
                              student.email ?? "-",
                              student.studentPhone ?? "-",
                              student.id,
                              student.isApproved ?? false);
                        },
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ));
  }

  Widget _buildStudentCardView(
      String name, String email, String mobileNo, String id, bool isApproved) {
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
                  'Name: $name',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  'Email: $email',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  'Mobile: $mobileNo',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  'ID: $id',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          !isApproved
              ? Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => () {},
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
                      onPressed: () => () {},
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
              : ElevatedButton(
                  onPressed: () => () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPallete.errorColor.withAlpha(150),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
    );
  }
}

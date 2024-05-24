import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:grad_ease/features/assignment/presentation/bloc/assignment_bloc/assignment_bloc.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({Key? key}) : super(key: key);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AssignmentBloc>().add(FetchAssignmentEvent());
  }

  bool _showPending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 14, right: 14, bottom: 10, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text(
                    'Pending',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  selected: _showPending,
                  selectedColor: ColorPallete.blue700,
                  onSelected: (selected) {
                    setState(() {
                      _showPending = true;
                    });
                  },
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: Text(
                    'Completed',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  selected: !_showPending,
                  selectedColor: ColorPallete.blue700,
                  onSelected: (selected) {
                    setState(() {
                      _showPending = false;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<AssignmentBloc, AssignmentState>(
              builder: (context, state) {
                if (state.notesStateStatus == AssignmentStateStatus.loading) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: ColorPallete.blue500));
                } else if (state.notesStateStatus ==
                    AssignmentStateStatus.error) {
                  return Center(
                    child: Text(state.errorMessage ?? 'An error occurred',
                        style: const TextStyle(color: ColorPallete.errorColor)),
                  );
                } else if (state.notesStateStatus ==
                    AssignmentStateStatus.success) {
                  final filteredAssignments =
                      state.assignments.where((assignment) {
                    final submissionDate =
                        DateTime.parse(assignment!.submittionDate);
                    if (_showPending) {
                      return submissionDate.isAfter(DateTime.now());
                    } else {
                      return submissionDate.isBefore(DateTime.now());
                    }
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredAssignments.length,
                    itemBuilder: (context, index) {
                      final assignment = filteredAssignments[index];
                      final formattedDate = DateFormat('MMM d, yyyy')
                          .format(DateTime.parse(assignment!.submittionDate));
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Card(
                          color: ColorPallete.grey500,
                          elevation: 3,
                          child: ListTile(
                            title: Text(
                              'Subject: ${assignment.title}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Description: ${assignment.description ?? ''}',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Submission Date: $formattedDate',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: ColorPallete.blue700,
                                      ),
                                ),
                              ],
                            ),
                            trailing: assignment.filepath != null
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.download_for_offline,
                                      size: 40,
                                    ),
                                    onPressed: () {
                                      context.read<AssignmentBloc>().add(
                                          OpenUrlEvent(assignment.filepath!));
                                    },
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

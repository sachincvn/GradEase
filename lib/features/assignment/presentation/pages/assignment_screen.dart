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

  void _showFullDescription(String title, String description) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 10),
                    SelectableText(
                      description,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignments"),
      ),
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
                        textAlign: TextAlign.center,
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
                  if (filteredAssignments.isEmpty) {
                    return Center(
                      child: Text(
                        _showPending
                            ? "No assignments present right now!"
                            : "No assignments found",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    );
                  }

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
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                if ((assignment.description?.length ?? 0) > 100)
                                  GestureDetector(
                                    onTap: () => _showFullDescription(
                                      assignment.title,
                                      assignment.description!,
                                    ),
                                    child: Text(
                                      'Tap to see more',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: ColorPallete.backgroundColor,
                                          ),
                                    ),
                                  ),
                                const SizedBox(height: 10),
                                Text(
                                  'Submission Date: $formattedDate',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: ColorPallete.blue700,
                                      ),
                                ),
                              ],
                            ),
                            onTap: (assignment.description?.length ?? 0) > 100
                                ? () => _showFullDescription(
                                      assignment.title,
                                      assignment.description!,
                                    )
                                : null,
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

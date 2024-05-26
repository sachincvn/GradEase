import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/widgets/confirmation_dailog.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/admin/presentation/bloc/timetable_bloc/timetable_bloc.dart';
import 'package:grad_ease/features/admin/presentation/pages/upsert_time_table_screen.dart';
import 'package:page_transition/page_transition.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({Key? key}) : super(key: key);

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TimetableBloc>().add(FetchAllTimeTable());
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
                child: const UpsertTimeTableScreen(),
              ));
        },
        child: const Icon(CupertinoIcons.add),
      ),
      appBar: AppBar(title: const Text("Manage Timetable")),
      body: SafeArea(
        child: BlocBuilder<TimetableBloc, TimetableState>(
          builder: (context, state) {
            if (state.status == TimetableStateStatus.loading) {
              return const Center(
                  child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ));
            } else if (state.status == TimetableStateStatus.error) {
              return Center(
                  child: Text(state.errorMessage ?? "Something went wrong"));
            } else if (state.status == TimetableStateStatus.success) {
              return ListView.builder(
                itemCount: state.timetables.length,
                itemBuilder: (context, index) {
                  final timeTable = state.timetables[index];
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
                                "Course : ${timeTable.course}",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Year : ${timeTable.year}",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Section : ${timeTable.section}",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "ID : ${timeTable.id}",
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
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: UpsertTimeTableScreen(
                                              upsertTimeTable: timeTable,
                                            ),
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
                                          context.read<TimetableBloc>().add(
                                                DeleteTimeTable(
                                                    timeTableModel: timeTable),
                                              );
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
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/timetable/data/models/time_table_entry_model.dart';
import 'package:grad_ease/features/timetable/presentation/bloc/time_table_bloc/time_table_bloc.dart';

class ClassScheduleScreen extends StatefulWidget {
  const ClassScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ClassScheduleScreen> createState() => _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  int selectedDayIndex = 0;

  final List<Color> _colors = [
    ColorPallete.blue700,
    Colors.orangeAccent,
    ColorPallete.blue500,
    Colors.purpleAccent,
    Colors.redAccent,
    ColorPallete.green500,
  ];

  @override
  void initState() {
    super.initState();
    context.read<TimeTableBloc>().add(FetchTimeTable(
          course: null,
          year: 1,
          section: "A",
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(7, (index) {
                    final dayInitial = _getDayInitial(index);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDayIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedDayIndex == index
                              ? Colors.blue
                              : ColorPallete.grey400,
                          borderRadius:
                              BorderRadius.circular(10), // Make it circular
                        ),
                        child: Text(dayInitial,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.only(
                    left: 5, right: 0, top: 10, bottom: 10),
                color: ColorPallete.whiteColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              text:
                                  "${context.read<TimeTableBloc>().currentDay}\n",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorPallete.grey400),
                              children: [
                                TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: ColorPallete.grey400),
                                  text: context
                                      .read<TimeTableBloc>()
                                      .currentMonthYear,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            context.read<TimeTableBloc>().currentDate,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: ColorPallete.backgroundColor,
                                    fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(
                      color: Color.fromARGB(255, 235, 225, 225),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Schedule",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorPallete.backgroundColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Color.fromARGB(255, 235, 225, 225),
                    ),
                    BlocConsumer<TimeTableBloc, TimeTableState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state.timeTableStateStatus ==
                            TimeTableStateStatus.loading) {
                          return const Center(
                              child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ));
                        } else if (state.timeTableStateStatus ==
                            TimeTableStateStatus.success) {
                          String selectedDay =
                              _getDayFromIndex(selectedDayIndex);
                          List<TimetableEntry>? entries =
                              state.timeTableEntity?.timetable[selectedDay];

                          return Expanded(
                            child: ListView.builder(
                              itemCount: entries?.length ?? 0,
                              itemBuilder: (context, index) {
                                Color entryColor =
                                    _colors[index % _colors.length];
                                TimetableEntry timetableEntry = entries![index];
                                return ListTile(
                                  titleAlignment: ListTileTitleAlignment.top,
                                  leading: Image.network(
                                    "https://cdn0.iconfinder.com/data/icons/3d-items/512/Calendar_date_appointment.png",
                                    height: 40,
                                    width: 40,
                                  ),
                                  title: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color:
                                          entryColor, // add random colors from a list of colors
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                timetableEntry.subjectName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: ColorPallete
                                                          .whiteColor,
                                                    ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                timetableEntry.teacherName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: ColorPallete
                                                          .whiteColor,
                                                    ),
                                              ),
                                              const SizedBox(height: 15),
                                              RichText(
                                                text: TextSpan(
                                                  text: "From ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: ColorPallete
                                                              .whiteColor),
                                                  children: [
                                                    TextSpan(
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: ColorPallete
                                                                  .whiteColor),
                                                      text: timetableEntry.time
                                                          .split('-')[0],
                                                    ),
                                                    TextSpan(
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color: ColorPallete
                                                                  .whiteColor),
                                                      text: " to ",
                                                    ),
                                                    TextSpan(
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: ColorPallete
                                                                  .whiteColor),
                                                      text: timetableEntry.time
                                                          .split('-')[1],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(Icons.chevron_right_outlined)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return const Text("Not Found");
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayInitial(int index) {
    switch (index) {
      case 0:
        return 'M';
      case 1:
        return 'T';
      case 2:
        return 'W';
      case 3:
        return 'T';
      case 4:
        return 'F';
      case 5:
        return 'S';
      case 6:
        return 'S';
      default:
        return '';
    }
  }

  String _getDayFromIndex(int index) {
    switch (index) {
      case 0:
        return 'Monday';
      case 1:
        return 'Tuesday';
      case 2:
        return 'Wednesday';
      case 3:
        return 'Thursday';
      case 4:
        return 'Friday';
      case 5:
        return 'Saturday';
      case 6:
        return 'Sunday';
      default:
        return '';
    }
  }
}

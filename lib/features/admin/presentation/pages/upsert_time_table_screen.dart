import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/widgets/dropdown_textfield.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_button.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/core/utils/show_snackbar.dart';
import 'package:grad_ease/features/admin/presentation/bloc/add_timetable/add_timetable_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/timetable_bloc/timetable_bloc.dart';
import 'package:grad_ease/features/timetable/data/models/time_table_entry_model.dart';
import 'package:grad_ease/features/timetable/data/models/time_table_model.dart';

class UpsertTimeTableScreen extends StatefulWidget {
  final TimeTableModel? upsertTimeTable;
  const UpsertTimeTableScreen({
    Key? key,
    this.upsertTimeTable,
  }) : super(key: key);
  @override
  State<UpsertTimeTableScreen> createState() => _UpsertTimeTableScreenState();
}

class _UpsertTimeTableScreenState extends State<UpsertTimeTableScreen> {
  final SingleValueDropDownController _yearController =
      SingleValueDropDownController();
  final SingleValueDropDownController _courseController =
      SingleValueDropDownController();
  final SingleValueDropDownController _sectionController =
      SingleValueDropDownController();

  final formKey = GlobalKey<FormState>();
  late bool isEditing = false;
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String? selectedDay = 'Monday';

  Map<String, List<SubjectEntry>> dayWiseEntries = {};

  @override
  void initState() {
    super.initState();
    dayWiseEntries = {for (var day in days) day: []};
    _setupUpsertData();
  }

  void _setupUpsertData() {
    if (widget.upsertTimeTable == null) {
      isEditing = false;
      return;
    }
    isEditing = true;
    final timetable = widget.upsertTimeTable!;

    _yearController.dropDownValue = DropDownValueModel(
      name: timetable.year.toString(),
      value: timetable.year,
    );

    _courseController.dropDownValue = DropDownValueModel(
      name: timetable.course,
      value: timetable.course,
    );

    _sectionController.dropDownValue = DropDownValueModel(
      name: timetable.section,
      value: timetable.section,
    );

    timetable.timetable.forEach((day, entries) {
      for (var entry in entries) {
        dayWiseEntries[day]!.add(
          SubjectEntry(
            headerValue: 'Subject ${dayWiseEntries[day]!.length + 1}',
            subjectNameController:
                TextEditingController(text: entry.subjectName),
            teacherNameController:
                TextEditingController(text: entry.teacherName),
            timingController: TextEditingController(text: entry.time),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _yearController.dispose();
    _courseController.dispose();
    _sectionController.dispose();
    super.dispose();
  }

  void _addNewItem() {
    setState(() {
      dayWiseEntries[selectedDay]!.add(SubjectEntry(
          headerValue: 'Subject ${dayWiseEntries[selectedDay]!.length + 1}'));
    });
  }

  void _removeItem(String day, int index) {
    setState(() {
      dayWiseEntries[day]!.removeAt(index);
    });
  }

  void _saveTimeTable() {
    Map<String, List<TimetableEntry>> timetable = {};
    for (var day in days) {
      List<TimetableEntry> dayEntries = [];
      for (var subject in dayWiseEntries[day]!) {
        dayEntries.add(TimetableEntry(
          subjectName: subject.subjectNameController.text,
          teacherName: subject.teacherNameController.text,
          time: subject.timingController.text,
          id: null,
        ));
      }
      timetable[day] = dayEntries;
    }

    final TimeTableModel timeTableModel = TimeTableModel(
      id: null,
      course: _courseController.dropDownValue!.value,
      section: _sectionController.dropDownValue!.value,
      year: _yearController.dropDownValue!.value,
      timetable: timetable,
    );

    if (isEditing) {
      context
          .read<AddTimetableBloc>()
          .add(UpdateTimeTableEvent(timeTableModel: timeTableModel));
    } else {
      context
          .read<AddTimetableBloc>()
          .add(SaveTimeTableEvent(timeTableModel: timeTableModel));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Timetable")),
      body: SafeArea(
        child: BlocConsumer<AddTimetableBloc, AddTimetableState>(
          listener: (context, state) {
            if (state is AddTimetablFailureState) {
              showErrorSnackBar(context, state.message);
            } else if (state is AddTimetablSuccessState) {
              context.read<TimetableBloc>().add(FetchAllTimeTable());
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            final isLoading = state is AddTimetablLoadingState;
            return Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Year",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            DropDownTextField(
                              controller: _yearController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a year';
                                }
                                return null;
                              },
                              listTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorPallete.backgroundColor,
                                  ),
                              dropDownList: const [
                                DropDownValueModel(name: "1", value: 1),
                                DropDownValueModel(name: "2", value: 2),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Course",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            DropDownTextField(
                              controller: _courseController,
                              listTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorPallete.backgroundColor,
                                  ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a course';
                                }
                                return null;
                              },
                              dropDownList: const [
                                DropDownValueModel(name: "MCA", value: "MCA"),
                                DropDownValueModel(name: "MBA", value: "MBA"),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Section",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            DropDownTextField(
                              controller: _sectionController,
                              listTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorPallete.backgroundColor,
                                  ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a section';
                                }
                                return null;
                              },
                              dropDownList: const [
                                DropDownValueModel(name: "A", value: "A"),
                                DropDownValueModel(name: "B", value: "B"),
                                DropDownValueModel(name: "C", value: "C"),
                              ],
                            ),
                            Container(
                              height: 50,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: days.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: ChoiceChip(
                                      label: Text(days[index]),
                                      selected: selectedDay == days[index],
                                      onSelected: (bool selected) {
                                        setState(() {
                                          if (selectedDay != days[index]) {
                                            selectedDay = days[index];
                                          }
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ExpansionPanelList(
                                    expansionCallback:
                                        (int index, bool isExpanded) {
                                      setState(() {
                                        dayWiseEntries[selectedDay]![index]
                                                .isExpanded =
                                            !dayWiseEntries[selectedDay]![index]
                                                .isExpanded;
                                      });
                                    },
                                    children: dayWiseEntries[selectedDay]!
                                        .map<ExpansionPanel>(
                                            (SubjectEntry item) {
                                      int index = dayWiseEntries[selectedDay]!
                                          .indexOf(item);
                                      return ExpansionPanel(
                                        headerBuilder: (BuildContext context,
                                            bool isExpanded) {
                                          return ListTile(
                                            title: Text(item.headerValue),
                                          );
                                        },
                                        body: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller:
                                                    item.subjectNameController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter subject name';
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                        labelText:
                                                            'Subject Name'),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller:
                                                    item.teacherNameController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter teacher name';
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                        labelText:
                                                            'Teacher Name'),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller:
                                                    item.timingController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter timing';
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                        labelText: 'Timing'),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () {
                                                  _removeItem(
                                                      selectedDay!, index);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        isExpanded: item.isExpanded,
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: _addNewItem,
                                    child: Text(
                                      "Add Subject",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: GradEaseButton(
                      buttonText: isEditing ? "Update" : "Save",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _saveTimeTable();
                        }
                      },
                      isLoading: isLoading,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class SubjectEntry {
  SubjectEntry({
    required this.headerValue,
    this.isExpanded = false,
    TextEditingController? subjectNameController,
    TextEditingController? teacherNameController,
    TextEditingController? timingController,
  })  : subjectNameController =
            subjectNameController ?? TextEditingController(),
        teacherNameController =
            teacherNameController ?? TextEditingController(),
        timingController = timingController ?? TextEditingController();

  String headerValue;
  bool isExpanded;
  final TextEditingController subjectNameController;
  final TextEditingController teacherNameController;
  final TextEditingController timingController;
}

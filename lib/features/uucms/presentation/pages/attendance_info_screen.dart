import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_attendance_info_bloc/uucms_attendance_info_bloc.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_bloc/uucms_bloc.dart';

class AttendanceInfoScreen extends StatefulWidget {
  const AttendanceInfoScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceInfoScreen> createState() => _AttendanceInfoScreenState();
}

class _AttendanceInfoScreenState extends State<AttendanceInfoScreen> {
  List<String> internalAssementsSemester = [];
  String? selectedSemester;
  List<TermDetails>? internalAssements;

  @override
  void initState() {
    super.initState();
    internalAssements = context.read<UUCMSBloc>().termDetails;
    if (internalAssements != null && internalAssements!.isNotEmpty) {
      for (var ia in internalAssements!) {
        internalAssementsSemester.add(ia.semester);
      }
      selectedSemester = internalAssementsSemester[0];
      context
          .read<UUCMSAttendanceInfoBloc>()
          .add(GetAttendanceInfoEvent(internalAssements![0].attendanceUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
        actions: [
          DropdownButton<String>(
            items: internalAssementsSemester.map((termName) {
              return DropdownMenuItem(
                value: termName,
                child: Text(termName),
              );
            }).toList(),
            value: selectedSemester,
            onChanged: (value) {
              setState(() {
                selectedSemester = value!;
              });
              if (internalAssements != null &&
                  internalAssements!.isNotEmpty &&
                  value != null) {
                final selectedSemeterUrlPath = internalAssements!
                    .firstWhere(
                        (element) => element.semester.trim() == value.trim())
                    .attendanceUrl;
                context
                    .read<UUCMSAttendanceInfoBloc>()
                    .add(GetAttendanceInfoEvent(selectedSemeterUrlPath));
              }
            },
          ),
          const SizedBox(width: 40),
        ],
      ),
      body: SafeArea(
          child:
              BlocConsumer<UUCMSAttendanceInfoBloc, UUCMSAttendanceInfoState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.uucmsAttendanceIfnoStateStatus ==
              UUCMSAttendanceInfoStateStatus.loading) {
            return const Center(
                child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(),
            ));
          } else if (state.uucmsAttendanceIfnoStateStatus ==
              UUCMSAttendanceInfoStateStatus.success) {
            return Container(
              padding: const EdgeInsets.only(bottom: 10, left: 14, right: 14),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 12, top: 15, right: 12, bottom: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 255, 230, 212),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "USN : ",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 197, 97, 0)),
                            children: [
                              TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromARGB(
                                            255, 197, 97, 0)),
                                text: state.uucmsStudentDetails!.usn ?? "",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: "Name : ",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 197, 97, 0)),
                            children: [
                              TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromARGB(
                                            255, 197, 97, 0)),
                                text: state.uucmsStudentDetails!.name ?? "",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: "Program Name : ",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 197, 97, 0)),
                            children: [
                              TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromARGB(
                                            255, 197, 97, 0)),
                                text: state.uucmsStudentDetails!.course ?? "",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: "Disipline Name : ",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromARGB(255, 197, 97, 0)),
                            children: [
                              TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromARGB(
                                            255, 197, 97, 0)),
                                text:
                                    state.uucmsStudentDetails!.discipline ?? "",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                      child: ListView.builder(
                    itemCount: state.attendanceDetails.length,
                    itemBuilder: (context, index) {
                      final attendanceDetail = state.attendanceDetails[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorPallete.grey500,
                        ),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: Color.fromARGB(255, 212, 255, 230),
                              ),
                              child: Text(
                                attendanceDetail.courseName ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color:
                                          const Color.fromARGB(255, 0, 197, 97),
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            buildHorizontalRichTextView(
                              context,
                              "Course Code",
                              attendanceDetail.courseCode ?? "",
                              "Component",
                              attendanceDetail.component ?? "",
                            ),
                            buildHorizontalRichTextView(
                              context,
                              "No of classes conducted",
                              attendanceDetail.classesConducted ?? "",
                              "No of classes attended",
                              attendanceDetail.classesAttended ?? "",
                            ),
                            buildHorizontalRichTextView(
                              context,
                              "Attendance %",
                              attendanceDetail.attendancePercentage ?? "",
                              "Status",
                              attendanceDetail.status ?? "",
                            ),
                          ],
                        ),
                      );
                    },
                  )),
                  const SizedBox(height: 10),
                ],
              ),
            );
          } else if (state.uucmsAttendanceIfnoStateStatus ==
              UUCMSAttendanceInfoStateStatus.error) {
            return Center(
              child: Text(
                state.errorMessage ?? "Something went wrong",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: ColorPallete.errorColor,
                    ),
              ),
            );
          }
          return const SizedBox();
        },
      )),
    );
  }

  Widget buildHorizontalRichTextView(
    BuildContext context,
    String nameOne,
    String valueOne,
    String nameTwo,
    String valueTwo,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "$nameOne : \n",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    text: valueOne,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "$nameTwo : \n",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    text: valueTwo,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

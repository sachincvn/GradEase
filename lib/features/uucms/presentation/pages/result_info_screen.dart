import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/uucms/presentation/bloc/uucms_result_info_bloc/uucms_result_bloc.dart';

class ResultInfoScreen extends StatefulWidget {
  const ResultInfoScreen({Key? key}) : super(key: key);

  @override
  State<ResultInfoScreen> createState() => _ResultInfoScreenState();
}

class _ResultInfoScreenState extends State<ResultInfoScreen> {
  late List<String> termsNames = [''];

  @override
  void initState() {
    super.initState();
    context.read<UUCMSExamResultBloc>().add(GetExamApplicationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: SafeArea(
          child: BlocBuilder<UUCMSExamResultBloc, UUCMSExamResultState>(
        builder: (context, state) {
          if (state.examApplicationStatus ==
              UUCMSExamResultStateStatus.loading) {
            return const Center(
                child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            ));
          } else if (state.examApplicationStatus ==
              UUCMSExamResultStateStatus.success) {
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
                                text: state.uucmsStudentDetails!.usn ?? "-",
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
                                text: state.uucmsStudentDetails!.name ?? "-",
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
                                text: state.uucmsStudentDetails!.course ?? "-",
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
                                text: state.uucmsStudentDetails!.discipline ??
                                    "-",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        items: context
                            .read<UUCMSExamResultBloc>()
                            .state
                            .termsNames!
                            .map((termName) {
                          return DropdownMenuItem(
                            value: termName,
                            child: Text(termName),
                          );
                        }).toList(),
                        value: state.selectedTerm,
                        onChanged: (value) {
                          context
                              .read<UUCMSExamResultBloc>()
                              .add(OnTermChangeEvent(selectedTerm: value!));
                        },
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: () {
                            context.read<UUCMSExamResultBloc>().add(
                                ViewResultEvent(termName: state.selectedTerm!));
                          },
                          child: const Text("View"))
                    ],
                  ),
                  const SizedBox(height: 10),
                  BlocConsumer<UUCMSExamResultBloc, UUCMSExamResultState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state.resultStatus ==
                          UUCMSExamResultStateStatus.loading) {
                        return const Center(
                            child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(),
                        ));
                      } else if (state.resultStatus ==
                          UUCMSExamResultStateStatus.success) {
                        if (state.examResults.isEmpty) {
                          return Expanded(
                              child: Center(
                            child: Text(
                              state.errorMessage ?? "Something went wrong",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ColorPallete.errorColor),
                            ),
                          ));
                        }
                        final resultCardData = state.examResults.last;
                        return Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      const Color.fromARGB(255, 212, 237, 255),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildResultCardTextView(
                                      "Result : ",
                                      resultCardData.ERStatus ?? "-",
                                      "Term Grade  : ",
                                      resultCardData.TermGrade ?? "-",
                                    ),
                                    const SizedBox(height: 10),
                                    _buildResultCardTextView(
                                      "CGPA : ",
                                      resultCardData.CGPA.toString(),
                                      "SGPA :",
                                      resultCardData.SGPA.toString(),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                  child: ListView.builder(
                                key: UniqueKey(),
                                itemCount: state.examResults.length,
                                itemBuilder: (context, index) {
                                  final result = state.examResults[index];
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
                                            color: Color.fromARGB(
                                                255, 212, 255, 230),
                                          ),
                                          child: Text(
                                            result.CourseName ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color: const Color.fromARGB(
                                                      255, 0, 197, 97),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        buildHorizontalRichTextView(
                                          context,
                                          "Course Code",
                                          result.CourseCode ?? "",
                                          "Credits",
                                          result.Credit.toString(),
                                        ),
                                        buildHorizontalRichTextView(
                                          context,
                                          "Maximum Marks",
                                          result.MaximumMarks.toString(),
                                          "Minimum Marks",
                                          result.MinimumMarks.toString(),
                                        ),
                                        buildHorizontalRichTextView(
                                          context,
                                          "SE Mark",
                                          result.SEMarks ?? "-",
                                          "IA Marks",
                                          result.IAMarks ?? "-",
                                        ),
                                        buildHorizontalRichTextView(
                                          context,
                                          "Marks Scored",
                                          result.MarksScored ?? "-",
                                          "Status",
                                          result.Status ?? "-",
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            );
          } else if (state.resultStatus == UUCMSExamResultStateStatus.error) {
            return Expanded(
                child: Center(
              child: Text(
                state.errorMessage ?? "Something went wrong",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorPallete.errorColor),
              ),
            ));
          }
          return const SizedBox(
            child: Text("Hello"),
          );
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

  Widget _buildResultCardTextView(
    String name1,
    String value1,
    String name2,
    String value2,
  ) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              text: name1,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 0, 122, 197)),
              children: [
                TextSpan(
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 0, 122, 197)),
                  text: value1,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: name2,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 0, 122, 197)),
              children: [
                TextSpan(
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 0, 122, 197)),
                  text: value2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

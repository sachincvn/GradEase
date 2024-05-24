import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/widgets/dropdown_textfield.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_button.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_field.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/core/utils/show_snackbar.dart';
import 'package:grad_ease/features/admin/presentation/bloc/admin_assignment/admin_assignment_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/upsert_assignment_bloc/upsert_assignment_bloc.dart';
import 'package:grad_ease/features/assignment/domain/entity/assignment_entity.dart';
import 'package:intl/intl.dart';

class UpsertAssignmentScreen extends StatefulWidget {
  final AssignmentEntity? assignmentEntity;
  const UpsertAssignmentScreen({this.assignmentEntity, Key? key})
      : super(key: key);

  @override
  State<UpsertAssignmentScreen> createState() => _UpsertAssignmentScreenState();
}

class _UpsertAssignmentScreenState extends State<UpsertAssignmentScreen> {
  final TextEditingController titleTextEditingController =
      TextEditingController();
  final TextEditingController descriptionTextEditingController =
      TextEditingController();
  final TextEditingController _submittionDateController =
      TextEditingController();
  final SingleValueDropDownController _yearController =
      SingleValueDropDownController();
  final SingleValueDropDownController _courseController =
      SingleValueDropDownController();
  final _formKey = GlobalKey<FormState>();
  bool isEditing = false;
  bool isFileSelected = false;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.assignmentEntity != null) {
      _populateFields();
      isEditing = true;
    }
  }

  void _populateFields() {
    titleTextEditingController.text = widget.assignmentEntity!.title;
    descriptionTextEditingController.text =
        widget.assignmentEntity!.description ?? '';
    _submittionDateController.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(widget.assignmentEntity!.submittionDate));
    _yearController.dropDownValue = DropDownValueModel(
        name: widget.assignmentEntity!.year.toString(),
        value: widget.assignmentEntity!.year);
    _courseController.dropDownValue = DropDownValueModel(
        name: widget.assignmentEntity!.course,
        value: widget.assignmentEntity!.course);
    _selectedDate = DateTime.parse(widget.assignmentEntity!.submittionDate);
    isFileSelected = widget.assignmentEntity?.filepath?.isNotEmpty ?? false;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null && _selectedDate!.isBefore(now)
          ? _selectedDate!
          : now,
      firstDate: DateTime(1900),
      lastDate: DateTime(2090),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _submittionDateController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void dispose() {
    titleTextEditingController.dispose();
    descriptionTextEditingController.dispose();
    _submittionDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: ColorPallete.whiteColor),
        centerTitle: true,
        title: Text(
          widget.assignmentEntity == null
              ? "Add Assignment"
              : "Edit Assignment",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<UpsertAssignmentBloc, UpsertAssignmentState>(
          listener: (context, state) {
            if (state is UpsertAssignmentFailureState) {
              showErrorSnackBar(context, state.message);
            }
            if (state is UpsertAssignmentSuccessState) {
              context
                  .read<AdminAssignmnetBloc>()
                  .add(FetchAllAdminAssignmnet());
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            final isLoading = state is UpsertAssignmentLoadingState;
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Course",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          DropDownTextField(
                            controller: _courseController,
                            listTextStyle:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                            "Year",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          DropDownTextField(
                            controller: _yearController,
                            listTextStyle:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorPallete.backgroundColor,
                                    ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a year';
                              }
                              return null;
                            },
                            dropDownList: const [
                              DropDownValueModel(name: "1", value: 1),
                              DropDownValueModel(name: "2", value: 2),
                            ],
                          ),
                          const SizedBox(height: 10),
                          GradEaseInputField(
                            labelText: "Subject",
                            hintText: "Enter Subject name",
                            controller: titleTextEditingController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a subject';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          GradEaseInputField(
                            labelText: "Description",
                            hintText: "Enter assignment description",
                            controller: descriptionTextEditingController,
                            maxLines: 5,
                            maxLength: 100,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          GradEaseInputField(
                            labelText: "Submission Date",
                            hintText: "Select the submission date",
                            controller: _submittionDateController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a submission date';
                              }
                              return null;
                            },
                            readOnly: true,
                            onTap: () => _selectDate(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: GradEaseButton(
                      buttonText: widget.assignmentEntity == null
                          ? "Add Assignment"
                          : "Update Assignment",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (isEditing) {
                            context.read<UpsertAssignmentBloc>().add(
                                UpsertAssignment(
                                    assignmentEntity: AssignmentEntity(
                                        id: widget.assignmentEntity!.id,
                                        uploadedBy: null,
                                        title: titleTextEditingController.text,
                                        description:
                                            descriptionTextEditingController
                                                .text,
                                        filepath: "",
                                        createdDate: "",
                                        submittionDate:
                                            _selectedDate!.toIso8601String(),
                                        course: _courseController
                                            .dropDownValue!.value,
                                        year: _yearController
                                            .dropDownValue!.value)));
                          } else {
                            context.read<UpsertAssignmentBloc>().add(
                                UpsertAssignment(
                                    assignmentEntity: AssignmentEntity(
                                        id: "",
                                        uploadedBy: null,
                                        title: titleTextEditingController.text,
                                        description:
                                            descriptionTextEditingController
                                                .text,
                                        filepath: "",
                                        createdDate: "",
                                        submittionDate:
                                            _selectedDate!.toIso8601String(),
                                        course: _courseController
                                            .dropDownValue!.value,
                                        year: _yearController
                                            .dropDownValue!.value)));
                          }
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

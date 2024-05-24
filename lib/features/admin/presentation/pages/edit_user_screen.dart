import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/widgets/dropdown_textfield.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_button.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_field.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/core/utils/show_snackbar.dart';
import 'package:grad_ease/features/admin/data/models/student_detail.dart';
import 'package:grad_ease/features/admin/presentation/bloc/edit_user_bloc/edit_user_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/students_bloc/students_bloc.dart';

class EditUserScreen extends StatefulWidget {
  final StudentDetail? userDetail;
  const EditUserScreen({this.userDetail, Key? key}) : super(key: key);

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _studentPhoneController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final SingleValueDropDownController _courseController =
      SingleValueDropDownController();
  final SingleValueDropDownController _genderController =
      SingleValueDropDownController();
  final SingleValueDropDownController _sectionController =
      SingleValueDropDownController();
  final SingleValueDropDownController _yearController =
      SingleValueDropDownController();
  final SingleValueDropDownController _roleController =
      SingleValueDropDownController();

  DateTime? _selectedDate;
  StudentDetail? studentDetail;

  @override
  void initState() {
    super.initState();
    if (widget.userDetail != null) {
      studentDetail = widget.userDetail;
      _nameController.text = widget.userDetail!.fullName;
      _fatherNameController.text = widget.userDetail!.fatherName ?? '';
      _dobController.text =
          widget.userDetail!.dob?.toLocal().toString().split(' ')[0] ?? '';
      _studentPhoneController.text = widget.userDetail!.studentPhone ?? '';
      _parentPhoneController.text = widget.userDetail!.parentPhone ?? '';
      _emailController.text = widget.userDetail!.email ?? '';

      _courseController.dropDownValue = DropDownValueModel(
        name: widget.userDetail!.course!,
        value: widget.userDetail!.course,
      );
      _genderController.dropDownValue = DropDownValueModel(
        name: widget.userDetail!.gender!,
        value: widget.userDetail!.gender,
      );
      _sectionController.dropDownValue = DropDownValueModel(
        name: widget.userDetail!.section ?? 'A',
        value: widget.userDetail!.section ?? 'A',
      );
      _yearController.dropDownValue = DropDownValueModel(
        name: widget.userDetail!.courseYear.toString(),
        value: widget.userDetail!.courseYear,
      );
      _roleController.dropDownValue = DropDownValueModel(
        name: widget.userDetail!.role.toString().split('.').last,
        value: widget.userDetail!.role,
      );
      _selectedDate = widget.userDetail!.dob;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _fatherNameController.dispose();
    _yearController.dispose();
    _sectionController.dispose();
    _dobController.dispose();
    _courseController.dispose();
    _emailController.dispose();
    _parentPhoneController.dispose();
    _studentPhoneController.dispose();
    _roleController.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      _selectedDate = picked;
      setState(() {
        _dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit User"),
      ),
      body: BlocConsumer<EditUserBloc, EditUserState>(
        listener: (context, state) {
          if (state is EditUserSuccessState) {
            context.read<StudentsBloc>().add(FetchAllStudents());
            Navigator.pop(context);
          } else if (state is EditUserErrorState) {
            showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is EditUserUpdatingState;
          return SafeArea(
              child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Role",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          DropDownTextField(
                            controller: _roleController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a role';
                              }
                              return null;
                            },
                            listTextStyle:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorPallete.backgroundColor,
                                    ),
                            dropDownList: const [
                              DropDownValueModel(
                                  name: "Student", value: "Student"),
                              DropDownValueModel(name: "Admin", value: "Admin"),
                              DropDownValueModel(
                                  name: "Teacher", value: "Teacher"),
                            ],
                          ),
                          const SizedBox(height: 10),
                          GradEaseInputField(
                            labelText: "Name",
                            hintText: "Enter student full name",
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Gender",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          DropDownTextField(
                            controller: _genderController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a gender';
                              }
                              return null;
                            },
                            listTextStyle:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorPallete.backgroundColor,
                                    ),
                            dropDownList: const [
                              DropDownValueModel(name: "Male", value: "Male"),
                              DropDownValueModel(
                                  name: "Female", value: "Female"),
                            ],
                          ),
                          const SizedBox(height: 10),
                          GradEaseInputField(
                            labelText: "Date of Birth",
                            hintText: "Select date of birth",
                            controller: _dobController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select date of birth';
                              }
                              return null;
                            },
                            readOnly: true,
                            onTap: () => _selectDate(context),
                          ),
                          const SizedBox(height: 10),
                          GradEaseInputField(
                            labelText: "Father name",
                            hintText: "Enter father name",
                            controller: _fatherNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the father name';
                              }
                              return null;
                            },
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
                          Text(
                            "Section",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          DropDownTextField(
                            controller: _sectionController,
                            listTextStyle:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                          const SizedBox(height: 10),
                          GradEaseInputField(
                            labelText: "Student Phone",
                            hintText: "Enter your phone number",
                            controller: _studentPhoneController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          GradEaseInputField(
                            labelText: "Parent Phone",
                            hintText: "Enter your parent number",
                            controller: _parentPhoneController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the parent phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          GradEaseInputField(
                            labelText: "Email",
                            hintText: "Enter the email address",
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: GradEaseButton(
                  buttonText: "Update",
                  isLoading: isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<EditUserBloc>().add(UpdateUserEvent(
                            fullName: _nameController.text,
                            fatherName: _fatherNameController.text,
                            dob: _selectedDate!.toLocal(),
                            gender: _genderController.dropDownValue!.value,
                            course: _courseController.dropDownValue!.value,
                            email: _emailController.text,
                            studentPhone: _studentPhoneController.text,
                            parentPhone: _parentPhoneController.text,
                            profileImage: studentDetail!.profileImage!,
                            year: _yearController.dropDownValue!.value,
                            section: _sectionController.dropDownValue!.value,
                            role: _roleController.dropDownValue!.value,
                          ));
                    }
                  },
                ),
              ),
            ],
          ));
        },
      ),
    );
  }
}

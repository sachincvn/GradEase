import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/entities/student_enity.dart';
import 'package:grad_ease/core/common/widgets/dropdown_textfield.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_button.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_field.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/constants/string_contants.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/profile/presentation/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:grad_ease/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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

  File? _imageFile;
  DateTime? _selectedDate;
  StudentEntity? studentEntity;
  String? profileImagePath = StringConstants.defaultAvatar;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EditProfileBloc>(context).add(FetchStudentDetailEvent());
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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

  void pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is StudentDataSuccessState) {
            studentEntity =
                BlocProvider.of<EditProfileBloc>(context).studentEntity;
            if (studentEntity != null) {
              _nameController.text = studentEntity!.fullName;
              _fatherNameController.text = studentEntity!.fatherName!;
              _dobController.text = studentEntity!.dob.toString().split(' ')[0];
              _studentPhoneController.text = studentEntity!.studentPhone!;
              _parentPhoneController.text = studentEntity!.parentPhone!;
              _emailController.text = studentEntity!.email!;
              _courseController.setDropDown(DropDownValueModel(
                  name: studentEntity!.course!.name,
                  value: studentEntity!.course!.name.toString()));
              _genderController.setDropDown(DropDownValueModel(
                  name: studentEntity!.gender!.name,
                  value: studentEntity!.gender!.name.toString()));
              _sectionController.setDropDown(DropDownValueModel(
                  name: studentEntity!.section!,
                  value: studentEntity!.section));
              _yearController.setDropDown(DropDownValueModel(
                  name: studentEntity!.courseYear.toString(),
                  value: studentEntity!.courseYear));
              profileImagePath = studentEntity!.profileImage;
            }
          } else if (state is EditProfileFailureSate) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is EditProfileSuccessState) {
            context.read<ProfileBloc>().add(FetchProfileStudentDetailEvent());
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is EditProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 5),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: GestureDetector(
                                  onTap: pickImage,
                                  child: _imageFile != null
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundImage:
                                              FileImage(_imageFile!),
                                        )
                                      : CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                              "${RestResources.imageBaseUrl}/$profileImagePath"),
                                        )),
                            ),
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
                              listTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
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
                              "Year",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            DropDownTextField(
                              controller: _yearController,
                              listTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final currentStudentEntity = studentEntity;
                        if (currentStudentEntity != null) {
                          BlocProvider.of<EditProfileBloc>(context)
                              .add(UpdateStudentEvent(
                            fullName: _nameController.text,
                            fatherName: _fatherNameController.text,
                            dob: _selectedDate ??
                                DateTime.parse(_dobController.text),
                            gender: _genderController.dropDownValue!.value
                                .toString(),
                            course: _courseController.dropDownValue!.value
                                .toString(),
                            year: int.parse(_yearController.dropDownValue!.value
                                .toString()),
                            section: _sectionController.dropDownValue!.value,
                            email: _emailController.text,
                            studentPhone: _studentPhoneController.text,
                            parentPhone: _parentPhoneController.text,
                            profileImage: _imageFile?.path ??
                                currentStudentEntity.profileImage!,
                          ));
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/widgets/dropdown_textfield.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_button.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_field.dart';
import 'package:grad_ease/core/extensions/spacing_extension.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/core/utils/show_snackbar.dart';
import 'package:grad_ease/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:grad_ease/features/auth/presentation/pages/student_login_screen.dart';
import 'package:page_transition/page_transition.dart';

class RegisterStudentScreen extends StatefulWidget {
  const RegisterStudentScreen({Key? key}) : super(key: key);

  @override
  State<RegisterStudentScreen> createState() => _RegisterStudentScreenState();
}

class _RegisterStudentScreenState extends State<RegisterStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _studentPhoneController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final SingleValueDropDownController _courseController =
      SingleValueDropDownController();
  final SingleValueDropDownController _genderController =
      SingleValueDropDownController();

  File? _imageFile;
  DateTime? _selectedDate;

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _fatherNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dobController.dispose();
    _courseController.dispose();
    _emailController.dispose();
    _parentPhoneController.dispose();
    _studentPhoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthRegisteredFailureState) {
              showErrorSnackBar(context, state.message);
            } else if (state is AuthRegisteredSuccessState) {
              showSnackBar(context, state.message);
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: const StudentLoginScreen(),
                ),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthRegisterLoading;
            return Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: context.topSpacing(4)),
                    Text(
                      "Register",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: context.topSpacing(2)),
                  ],
                ),
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
                            Text(
                              "Profile Image",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: pickImage,
                                child: _imageFile != null
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundImage: FileImage(_imageFile!),
                                      )
                                    : const CircleAvatar(
                                        radius: 50,
                                        child: Icon(Icons.add_a_photo),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 20),
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
                            GradEaseInputField(
                              labelText: "Password",
                              hintText: "Enter password",
                              controller: _passwordController,
                              isObscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            GradEaseInputField(
                              labelText: "Confirm Password",
                              hintText: "Enter confirm password",
                              controller: _confirmPasswordController,
                              isObscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm the password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
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
                    isLoading: isLoading,
                    buttonText: "SignUp",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(RegisterStudentEvent(
                              fullName: _nameController.text,
                              fatherName: _fatherNameController.text,
                              dob: _selectedDate!,
                              gender: _genderController.dropDownValue!.value,
                              course: _courseController.dropDownValue!.value,
                              email: _emailController.text,
                              studentPhone: _studentPhoneController.text,
                              parentPhone: _parentPhoneController.text,
                              password: _passwordController.text,
                              profileImage: _imageFile!.path,
                            ));
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

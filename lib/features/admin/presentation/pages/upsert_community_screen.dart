import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/widgets/dropdown_textfield.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_button.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_field.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:file_picker/file_picker.dart';
import 'package:grad_ease/core/utils/show_snackbar.dart';
import 'dart:io';

import 'package:grad_ease/features/admin/presentation/bloc/add_community/add_community_bloc.dart';
import 'package:grad_ease/features/admin/presentation/bloc/communites_bloc/communites_bloc.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';

class UpsertCommunityScreen extends StatefulWidget {
  final CommunityEntity? communityEntity;
  const UpsertCommunityScreen({Key? key, this.communityEntity})
      : super(key: key);

  @override
  State<UpsertCommunityScreen> createState() => _UpsertCommunityScreenState();
}

class _UpsertCommunityScreenState extends State<UpsertCommunityScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final SingleValueDropDownController _yearController =
  SingleValueDropDownController();
  final SingleValueDropDownController _courseController =
  SingleValueDropDownController();
  File? _imageFile;
  final formKey = GlobalKey<FormState>();
  late CommunityEntity? _communityEntity;
  late bool isEditing;

  @override
  void initState() {
    super.initState();
    _communityEntity = widget.communityEntity!;
    isEditing = (_communityEntity != null);
    if (isEditing) _updateExistingData();
  }

  void _updateExistingData() {
    if (_communityEntity != null) {
      _nameController.text = _communityEntity!.name;
      _descriptionController.text = _communityEntity!.description;
      _yearController.dropDownValue = DropDownValueModel(
        name: _communityEntity!.year.toString(),
        value: _communityEntity!.year,
      );
      _courseController.dropDownValue = DropDownValueModel(
        name: _communityEntity!.course.toString(),
        value: _communityEntity!.course,
      );
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

  void deleteCommunity() {
    // Implement the delete functionality
    // You might want to call a delete method from your BLoC
  }

  @override
  void dispose() {
    super.dispose();
    _courseController.dispose();
    _yearController.dispose();
    _descriptionController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Community" : "Add Community"),
        actions: isEditing
            ? [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: deleteCommunity,
          ),
        ]
            : null,
      ),
      body: SafeArea(
        child: BlocConsumer<AddCommunityBloc, AddCommunityState>(
          listener: (context, state) {
            if (state is AddCommunityFailureState) {
              showErrorSnackBar(context, state.message);
            } else if (state is AddCommunitySuccessState) {
              context.read<CommunitesBloc>().add(FetchAllCommunites());
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            final isLoading = state is AddCommunityLoadingState;
            return Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: pickImage,
                                child: _imageFile != null
                                    ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(_imageFile!),
                                )
                                    : isEditing
                                    ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      "${RestResources.imageBaseUrl}/${_communityEntity!.profileImage}"),
                                )
                                    : const CircleAvatar(
                                  radius: 50,
                                  child: Icon(Icons.add_a_photo),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
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
                            GradEaseInputField(
                              labelText: "Community name",
                              hintText: "Enter community name",
                              controller: _nameController,
                            ),
                            const SizedBox(height: 10),
                            GradEaseInputField(
                              labelText: "Community description",
                              hintText: "Enter community description",
                              controller: _descriptionController,
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
                      buttonText: isEditing ? "Update" : "Add",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (isEditing) {
                            context.read<AddCommunityBloc>().add(UpdateCommunityEvent(communityId: _communityEntity!.id, communityName: _communityEntity!.name, communityDescription: _communityEntity!.description, profilePath: _communityEntity!.profileImage, profileName: "", year: _communityEntity!.year, course: _communityEntity!.course));
                          } else {
                            context.read<AddCommunityBloc>().add(
                              SaveCommunityEvent(
                                communityName: _nameController.text,
                                communityDescription:
                                _descriptionController.text,
                                profilePath: _imageFile!.path,
                                profileName: _imageFile!.path,
                                year: _yearController.dropDownValue!.value,
                                course:
                                _courseController.dropDownValue!.value,
                              ),
                            );
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


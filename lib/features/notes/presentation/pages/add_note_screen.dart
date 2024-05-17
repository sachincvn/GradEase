import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_button.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_field.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/core/utils/show_snackbar.dart';
import 'package:grad_ease/features/notes/presentation/bloc/add_note_bloc/add_note_bloc_bloc.dart';
import 'package:grad_ease/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleTextEditingController =
      TextEditingController();
  final TextEditingController descriptionTextEditingController =
      TextEditingController();
  File? _selectedFile;

  void _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
      }
    } catch (e) {}
  }

  void _removeFile() {
    setState(() {
      _selectedFile = null;
    });
  }

  @override
  void dispose() {
    titleTextEditingController.dispose();
    descriptionTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: ColorPallete.whiteColor),
        centerTitle: true,
        title: Text(
          "Add Note",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<AddNoteBloc, AddNoteBlocState>(
          listener: (context, state) {
            if (state is AddNoteFailureState) {
              showErrorSnackBar(context, state.message);
            }
            if (state is AddNoteSuccessState) {
              context
                  .read<NotesBloc>()
                  .add(InsertNewNoteEvent(state.noteEntity));
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            final isLoading = state is AddNoteLoadingState;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GradEaseInputField(
                          labelText: "Title",
                          hintText: "Enter discussion title",
                          controller: titleTextEditingController,
                        ),
                        const SizedBox(height: 20),
                        GradEaseInputField(
                          labelText: "Description",
                          hintText: "Enter description",
                          controller: descriptionTextEditingController,
                          maxLines: 5,
                          maxLength: 100,
                        ),
                        const SizedBox(height: 20),
                        _selectedFile == null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Select File",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: () {
                                      _pickFile();
                                    },
                                    child: Container(
                                      height: 100,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorPallete.grey400),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                              CupertinoIcons.cloud_upload),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Select File: (Jpg, png, pdf) MAX: 10MB",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              )
                            : Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorPallete.grey400,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _selectedFile!.path.split('/').last,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _removeFile,
                                      icon: Icon(
                                        Icons.remove_circle_outline_outlined,
                                        color: Colors.red.shade400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: GradEaseButton(
                    buttonText: "Upload Note",
                    onPressed: () {
                      context.read<AddNoteBloc>().add(AddNewNoteEvent(
                            filePath: _selectedFile!.path,
                            title: titleTextEditingController.text,
                            desctipiton: descriptionTextEditingController.text,
                            fileName: _selectedFile!.path.split('/').last,
                          ));
                    },
                    isLoading: isLoading,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_button.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_field.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/core/utils/show_snackbar.dart';
import 'package:grad_ease/features/feeds/domain/usecase/add_post_use_case.dart';
import 'package:grad_ease/features/feeds/presentation/bloc/add_post_bloc/add_post_bloc_bloc.dart';
import 'package:grad_ease/features/feeds/presentation/bloc/feeds_bloc/feed_post_bloc.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController titleTextEditingController =
      TextEditingController();
  final TextEditingController descriptionTextEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    titleTextEditingController.dispose();
    descriptionTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPostBloc, AddPostBlocState>(
      listener: (context, state) {
        if (state is AddPostFailureState) {
          showErrorSnackBar(context, state.message);
        }
        if (state is AddPostSuccessState) {
          context
              .read<FeedPostBloc>()
              .add(InsertNewPostEvent(state.feedPostEntity));
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final isLoading = state is AddPostLoadingState;
        return Scaffold(
            appBar: AppBar(
              leading: const BackButton(color: ColorPallete.whiteColor),
              centerTitle: true,
              title: Text(
                "Add Post",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      GradEaseInputField(
                        labelText: "Title",
                        hintText: "Enter discussion title",
                        controller: titleTextEditingController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the discussion title";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GradEaseInputField(
                        labelText: "Description",
                        hintText: "Enter description",
                        controller: descriptionTextEditingController,
                        maxLines: 5,
                        maxLength: 400,
                        validator: (value) {
                          if (value == null || value.length < 10) {
                            return "Please enter the description";
                          }
                          return null;
                        },
                      ),
                      const Spacer(),
                      GradEaseButton(
                        buttonText: "Start discussion",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AddPostBloc>().add(
                                  AddNewPostEvent(
                                    AddPostParams(
                                        title: titleTextEditingController.text
                                            .trim(),
                                        description:
                                            descriptionTextEditingController
                                                .text
                                                .trim()),
                                  ),
                                );
                          }
                        },
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}

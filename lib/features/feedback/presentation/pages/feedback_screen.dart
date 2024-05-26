import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_button.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_field.dart';
import 'package:grad_ease/core/utils/show_snackbar.dart';
import 'package:grad_ease/features/feedback/presentation/bloc/feedback_bloc/feedback_bloc.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackMessageController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
      ),
      body: BlocConsumer<FeedbackBloc, FeedbackState>(
        listener: (context, state) {
          if (state is FeedbackError) {
            showErrorSnackBar(context, state.message);
          }
          if (state is FeedbackSuccess) {
            showSnackBar(context, "Feedback sent successfully");
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final isLoading = state is FeedbackSending;
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GradEaseInputField(
                    labelText: "Message",
                    hintText: "Enter your feedback here..",
                    controller: _feedbackMessageController,
                    maxLength: 500,
                    maxLines: 10,
                    validator: (value) {
                      if (value == null) {
                        return "Feedback message is required";
                      } else if (value.length < 10) {
                        return "Feedback message must be larger";
                      }
                      return null;
                    },
                  ),
                  GradEaseButton(
                      buttonText: "Submit",
                      isLoading: isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<FeedbackBloc>().add(SendFeedbackEvent(
                              message: _feedbackMessageController.text));
                        }
                      })
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}

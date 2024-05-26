import 'package:flutter/material.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_button.dart';
import 'package:grad_ease/core/common/widgets/grad_ease_field.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GradEaseInputField(
              labelText: "Feedback description",
              hintText: "Enter the feedback title",
              controller: _descriptionController,
              maxLength: 500,
              maxLines: 10,
            ),
            GradEaseButton(buttonText: "Submit", onPressed: () {})
          ],
        ),
      )),
    );
  }
}

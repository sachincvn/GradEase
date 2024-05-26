import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/extensions/string_extension.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/admin/presentation/bloc/admin_feedback/admin_feedback_bloc.dart';

class FeedbacksScreen extends StatefulWidget {
  const FeedbacksScreen({Key? key}) : super(key: key);

  @override
  State<FeedbacksScreen> createState() => _FeedbacksScreenState();
}

class _FeedbacksScreenState extends State<FeedbacksScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminFeedbackBloc>().add(FetchAllFeedbacks());
  }

  void _showFullDescription(String title, String description) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 10),
                    SelectableText(
                      description,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedbacks"),
      ),
      body: BlocConsumer<AdminFeedbackBloc, AdminFeedbackState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AdminFeedbackLoading) {
            return const Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AdminFeedbackError) {
            return Center(
              child: Text(state.message ?? "Something went wrong"),
            );
          } else if (state is AdminFeedbackSuccess) {
            return SafeArea(
                child: ListView.builder(
              itemCount: state.feedbacks.length,
              itemBuilder: (context, index) {
                final feedback = state.feedbacks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    color: ColorPallete.grey500,
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        'From: ${feedback!.name}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Feedback Message : ${feedback.message}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          if ((feedback.message.length) > 100)
                            GestureDetector(
                              onTap: () => _showFullDescription(
                                feedback.name,
                                feedback.message,
                              ),
                              child: Text(
                                'Tap to see more',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ColorPallete.backgroundColor,
                                    ),
                              ),
                            ),
                          const SizedBox(height: 10),
                          Text(
                            'Created on: ${feedback.createdAt.toString().formatDateTime('yyyy-MM-dd hh:mm a')}',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: ColorPallete.backgroundColor,
                                ),
                          ),
                        ],
                      ),
                      onTap: (feedback.message.length) > 100
                          ? () => _showFullDescription(
                                feedback.name,
                                feedback.message,
                              )
                          : null,
                    ),
                  ),
                );
              },
            ));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:grad_ease/features/notes/presentation/pages/add_note_screen.dart';
import 'package:grad_ease/features/notes/presentation/widgets/note_card_widget.dart';
import 'package:page_transition/page_transition.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(FetchAllNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorPallete.greyColor,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const AddNoteScreen(),
                ));
          },
          child: const Icon(CupertinoIcons.add),
        ),
        body: Expanded(
            child: BlocConsumer<NotesBloc, NotesState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.notesStateStatus == NotesStateStatus.loading) {
              return const Center(
                  child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ));
            } else if (state.notesStateStatus == NotesStateStatus.success) {
              return ListView.builder(
                key: UniqueKey(),
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  return NoteCard(
                    note: state.notes[index]!,
                    onRemoveNoteCallBack: () {
                      context
                          .read<NotesBloc>()
                          .add(RemoveNoteEvent(state.notes[index]!.id));
                    },
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          },
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:note_app/views/widgets/note_list_body.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: NoteListViewBody(),
      ),
    );
  }
}

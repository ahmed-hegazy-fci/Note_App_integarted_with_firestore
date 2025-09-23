import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/views/widgets/note_details_body.dart';

class NoteDetailsView extends StatelessWidget {
  final NoteModel note;
  const NoteDetailsView({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Details'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: NoteDetailsBody(note: note),
      ),
    );
  }
}

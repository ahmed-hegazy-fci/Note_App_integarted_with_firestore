import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';

class NoteDetailsBody extends StatelessWidget {
  final NoteModel note;
  const NoteDetailsBody({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          note.title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          note.description,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 8),
        Text(
          'Created At: '
          '${note.date.year.toString().padLeft(4, '0')}-${note.date.month.toString().padLeft(2, '0')}-${note.date.day.toString().padLeft(2, '0')} (${note.date.hour.toString().padLeft(2, '0')}:${note.date.minute.toString().padLeft(2, '0')})',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF0AD9D9),
          ),
        ),
      ],
    );
  }
}

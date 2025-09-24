import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/controller/cubit/note_cubit.dart';
import 'package:note_app/views/screens/note_details_view.dart';

class NoteListViewBody extends StatelessWidget {
  const NoteListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<NoteCubit>(context);
    return StreamBuilder<List<NoteModel>>(
      stream: cubit.getNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final notes = snapshot.data ?? const <NoteModel>[];
        if (notes.isEmpty) {
          return const Center(child: Text('empty List'));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: notes.length,
                itemBuilder: (_, index) {
                  final list = notes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => NoteDetailsView(note: list),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(
                        list.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      subtitle: Text(
                        list.description,
                        style: const TextStyle(
                          color: Color(0xFF4A9C9C),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          await cubit.deleteNote(list.date.toString());
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

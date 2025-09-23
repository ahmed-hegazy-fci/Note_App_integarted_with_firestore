import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/controller/cubit/note_cubit.dart';
import 'package:note_app/views/screens/notes_list_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: BlocProvider.of<NoteCubit>(context).formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              const Text(
                'Note Title',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Content cannot be empty';
                  }
                  return null;
                },

                controller: BlocProvider.of<NoteCubit>(context).title,
                decoration: InputDecoration(
                  hintText: 'Enter  note title',
                  hintStyle: TextStyle(color: Color(0xFF0AD9D9)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF0AD9D9)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Content',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: BlocProvider.of<NoteCubit>(context).desc,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Content cannot be empty';
                  }
                  return null;
                },
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Enter  note content',
                  hintStyle: TextStyle(color: Color(0xFF0AD9D9)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF0AD9D9)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 120),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0AD9D9),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (BlocProvider.of<NoteCubit>(
                      context,
                    ).formKey.currentState!.validate()) {
                      BlocProvider.of<NoteCubit>(context).addNoteToList(
                        NoteModel(
                          date: DateTime.now(),
                          title: BlocProvider.of<NoteCubit>(context).title.text,
                          description: BlocProvider.of<NoteCubit>(
                            context,
                          ).desc.text,
                        ),
                      );
                      BlocProvider.of<NoteCubit>(context).addNoteToData(
                        NoteModel(
                          date: DateTime.now(),
                          title: BlocProvider.of<NoteCubit>(context).title.text,
                          description: BlocProvider.of<NoteCubit>(
                            context,
                          ).desc.text,
                        ),
                      );
                      BlocProvider.of<NoteCubit>(
                        context,
                      ).formKey.currentState!.reset();
                    }
                  },
                  child: const Text(
                    'Save Note',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => NotesListView()));
                  },
                  child: const Text(
                    'View Notes',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

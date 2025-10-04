import 'dart:developer';
import 'note_state.dart';
import 'package:note_app/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/models/note_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection(
    FireBaseKeys.notes,
  );

  Future<void> addNoteToData(NoteModel note) {
    return users
        .add(note.toMap())
        .then((value) => log("Note Added"))
        .catchError((error) => log("Failed to add Note: $error"));
  }

  Stream<List<NoteModel>> getNotes() {
    return users
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => NoteModel.fromMap(doc.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }

  Future<void> deleteNote(String noteDate) async {
    try {
      await users.doc(noteDate).delete();
      log("Note Deleted");
    } catch (error) {
      log("Failed to delete Note: $error");
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    emit(LoginLoadingState());
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      emit(LoginSuccessState());

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      emit(LoginLErrorState(error: e.toString()));
    }

    return Future.value(null);
  }
}

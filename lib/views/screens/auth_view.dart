import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/views/screens/home_view.dart';
import 'package:note_app/controller/cubit/note_cubit.dart';
import 'package:note_app/controller/cubit/note_state.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    NoteCubit cubit = BlocProvider.of<NoteCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              CircleAvatar(
                radius: 48,
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.note, size: 48, color: Colors.blue),
              ),
              const SizedBox(height: 24),
              // Title
              const Text(
                'Sign in to Notes App',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              // Google Sign-In Button
              BlocConsumer(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const HomeView()),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoadingState) {
                    return const CircularProgressIndicator();
                  }
                  return signInBtn(cubit);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox signInBtn(NoteCubit cubit) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.login_rounded),
        label: const Text('Sign in with Google'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 2,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.grey),
          ),
        ),
        onPressed: () async {
          await cubit.signInWithGoogle();
        },
      ),
    );
  }
}

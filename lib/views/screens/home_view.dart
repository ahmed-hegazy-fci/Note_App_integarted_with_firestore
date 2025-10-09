import 'package:flutter/material.dart';
import 'package:note_app/views/screens/auth_view.dart';
import 'package:note_app/views/widgets/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Note'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AuthView()),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const HomeViewBody(),
    );
  }
}
